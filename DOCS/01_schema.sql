-- ============================================================
-- THE FINANCIAL CLUB — Head of Sales Agent
-- Supabase Schema v2.0
-- ============================================================
-- Changes from v1:
--   CONTACTS: Removed last_event_date, engagement_score,
--             app_user_id, preferred_event_types
--   EVENTS:   Replaced price_nonmember/price_member with
--             pricing JSONB (supports multi-tier pricing)
--   CAMPAIGNS: Removed total_opened
--   OUTREACH_LOG: Removed opened_at, clicked_at, scheduled_at;
--                 simplified status enum (no open/click tracking)
--   EMAIL_TEMPLATES: Removed avg_open_rate
-- ============================================================

-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- 1. CONTACTS
-- The single source of truth for all club relationships.
-- Synced from Notion initially, eventually from the app DB.
-- ============================================================
CREATE TABLE contacts (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Identity
    first_name      TEXT NOT NULL,
    last_name       TEXT NOT NULL,
    email           TEXT UNIQUE NOT NULL,
    phone           TEXT,
    linkedin_url    TEXT,

    -- Professional
    company         TEXT,
    job_title       TEXT,
    industry        TEXT CHECK (industry IN (
        'banking', 'payments', 'lending', 'insurance',
        'risk_management', 'compliance', 'venture_capital',
        'law', 'government', 'academia', 'crypto_web3',
        'consulting', 'technology', 'other'
    )),

    -- Club relationship
    membership_tier TEXT NOT NULL DEFAULT 'prospect' CHECK (membership_tier IN (
        'prospect', 'core', 'plus', 'premier'
    )),
    contact_type    TEXT NOT NULL DEFAULT 'prospect' CHECK (contact_type IN (
        'member', 'prospect', 'speaker', 'sponsor', 'partner', 'media'
    )),
    status          TEXT NOT NULL DEFAULT 'active' CHECK (status IN (
        'active', 'inactive', 'churned', 'blacklisted'
    )),

    -- Geography
    city            TEXT,
    country         TEXT DEFAULT 'US',

    -- Engagement signals
    events_attended INTEGER DEFAULT 0,

    -- External references (for sync)
    notion_id       TEXT,

    -- Preferences
    email_opted_out BOOLEAN DEFAULT FALSE,

    -- Metadata
    notes           TEXT,
    tags            TEXT[],
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast lookups during campaign targeting
CREATE INDEX idx_contacts_tier ON contacts(membership_tier);
CREATE INDEX idx_contacts_type ON contacts(contact_type);
CREATE INDEX idx_contacts_city ON contacts(city);
CREATE INDEX idx_contacts_industry ON contacts(industry);
CREATE INDEX idx_contacts_status ON contacts(status);
CREATE INDEX idx_contacts_email ON contacts(email);

-- ============================================================
-- 2. EVENTS
-- Every club event, from intimate breakfasts to retreats.
-- This mirrors what exists in the app database.
-- ============================================================
CREATE TABLE events (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Core info
    name            TEXT NOT NULL,
    slug            TEXT UNIQUE,
    event_type      TEXT NOT NULL CHECK (event_type IN (
        'member_meeting', 'connect_series', 'delegation',
        'retreat', 'cyber_connect', 'fintech_fest',
        'breakfast', 'dinner', 'podcast_live', 'webinar'
    )),
    description     TEXT,

    -- Logistics
    date_start      TIMESTAMPTZ NOT NULL,
    date_end        TIMESTAMPTZ,
    city            TEXT,
    venue           TEXT,
    capacity        INTEGER,

    -- Access rules
    access_type     TEXT DEFAULT 'members_only' CHECK (access_type IN (
        'free', 'members_only', 'paid', 'application_only', 'invite_only'
    )),
    eligible_tiers  TEXT[] DEFAULT '{core,plus,premier}',

    -- Pricing (flexible multi-tier structure)
    pricing         JSONB DEFAULT '{}',
    -- Examples:
    -- Delegation: {"delegation_only": {"price": 799, "label": "Delegation-Only Access", "note": "Already hold a pass"}, "premier": {"price": 1699, "label": "Premier Delegate"}, "plus": {"price": 2299, "label": "Plus Delegate"}, "core": {"price": 2499, "label": "Core Delegate"}}
    -- Connect Series: {"plus": {"price": 599, "label": "Plus Members", "includes": "Reception, panels, roundtables, lunch, evening drinks"}}
    -- Free event: {}

    -- Content
    speakers        JSONB DEFAULT '[]',
    -- Format: [{"name": "...", "title": "...", "company": "...", "topic": "..."}]
    agenda_summary  TEXT,

    -- Status
    status          TEXT DEFAULT 'draft' CHECK (status IN (
        'draft', 'announced', 'registration_open',
        'sold_out', 'completed', 'cancelled'
    )),
    registration_url TEXT,

    -- Metadata
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_date ON events(date_start);
CREATE INDEX idx_events_type ON events(event_type);

-- ============================================================
-- 3. CAMPAIGNS
-- Each outreach campaign is tied to an event (or a general
-- sales push like Premier membership upsell).
-- ============================================================
CREATE TABLE campaigns (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- What this campaign is for
    event_id        UUID REFERENCES events(id) ON DELETE SET NULL,
    name            TEXT NOT NULL,
    campaign_type   TEXT NOT NULL DEFAULT 'event_announcement' CHECK (campaign_type IN (
        'event_announcement',
        'event_followup',
        'membership_upsell',
        're_engagement',
        'welcome_series',
        'custom'
    )),

    -- Targeting
    target_segment  JSONB DEFAULT '{}',
    -- Example: {"membership_tier": ["core","plus","premier"], "city": ["San Francisco","New York"], "industry": ["banking","payments"]}

    -- Sequence configuration
    max_follow_ups          INTEGER DEFAULT 3,
    follow_up_interval_days INTEGER DEFAULT 3,

    -- Status
    status          TEXT DEFAULT 'draft' CHECK (status IN (
        'draft', 'active', 'paused', 'completed', 'cancelled'
    )),

    -- Stats (denormalized for quick dashboard reads)
    total_contacts  INTEGER DEFAULT 0,
    total_sent      INTEGER DEFAULT 0,
    total_replied   INTEGER DEFAULT 0,
    total_converted INTEGER DEFAULT 0,

    -- Metadata
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    started_at      TIMESTAMPTZ,
    completed_at    TIMESTAMPTZ,
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_campaigns_status ON campaigns(status);
CREATE INDEX idx_campaigns_event ON campaigns(event_id);

-- ============================================================
-- 4. OUTREACH LOG
-- The granular record of every email sent per contact per
-- campaign. This is the "state machine" the n8n agent uses
-- to decide what to do next.
-- ============================================================
CREATE TABLE outreach_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- References
    campaign_id     UUID NOT NULL REFERENCES campaigns(id) ON DELETE CASCADE,
    contact_id      UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,

    -- Sequence position
    sequence_step   INTEGER NOT NULL DEFAULT 1,
    -- 1 = initial announcement, 2 = first follow-up, 3 = second follow-up, etc.

    -- Email content (stored for audit trail)
    email_subject   TEXT,
    email_body      TEXT,
    template_used   TEXT,

    -- Delivery & engagement status (reply tracking only — no open/click tracking)
    status          TEXT NOT NULL DEFAULT 'pending' CHECK (status IN (
        'pending',
        'sent',
        'replied',
        'bounced',
        'unsubscribed',
        'converted'
    )),

    -- Timestamps
    sent_at         TIMESTAMPTZ,
    replied_at      TIMESTAMPTZ,

    -- Follow-up scheduling
    next_followup_at    TIMESTAMPTZ,
    followup_exhausted  BOOLEAN DEFAULT FALSE,

    -- Metadata
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),

    -- Prevent duplicate sends
    UNIQUE(campaign_id, contact_id, sequence_step)
);

CREATE INDEX idx_outreach_campaign ON outreach_log(campaign_id);
CREATE INDEX idx_outreach_contact ON outreach_log(contact_id);
CREATE INDEX idx_outreach_status ON outreach_log(status);
CREATE INDEX idx_outreach_next_followup ON outreach_log(next_followup_at)
    WHERE followup_exhausted = FALSE AND status NOT IN ('replied', 'converted', 'unsubscribed', 'bounced');

-- ============================================================
-- 5. EMAIL TEMPLATES
-- Pre-built templates the AI agent can select from or use as
-- inspiration when generating personalized emails.
-- ============================================================
CREATE TABLE email_templates (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    name            TEXT NOT NULL UNIQUE,
    category        TEXT NOT NULL CHECK (category IN (
        'event_announcement', 'follow_up_1', 'follow_up_2',
        'follow_up_3', 'membership_upsell', 'welcome',
        're_engagement', 'custom'
    )),
    subject_template TEXT NOT NULL,
    body_template   TEXT NOT NULL,
    -- Templates use {{variable}} syntax: {{first_name}}, {{event_name}}, {{event_date}}, etc.

    -- Performance tracking (reply rate only — no open tracking)
    times_used      INTEGER DEFAULT 0,
    avg_reply_rate  DECIMAL(5,2),

    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 6. EVENT REGISTRATIONS (bridge table)
-- Track who registered/attended which events.
-- Critical for the agent to know engagement history.
-- ============================================================
CREATE TABLE event_registrations (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id        UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    contact_id      UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,

    registration_status TEXT DEFAULT 'registered' CHECK (registration_status IN (
        'registered', 'waitlisted', 'confirmed', 'attended',
        'no_show', 'cancelled'
    )),

    source          TEXT,  -- 'email_campaign', 'direct', 'referral', 'website'
    campaign_id     UUID REFERENCES campaigns(id),

    registered_at   TIMESTAMPTZ DEFAULT NOW(),
    attended_at     TIMESTAMPTZ,

    UNIQUE(event_id, contact_id)
);

CREATE INDEX idx_registrations_event ON event_registrations(event_id);
CREATE INDEX idx_registrations_contact ON event_registrations(contact_id);

-- ============================================================
-- HELPER: Auto-update updated_at timestamps
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_contacts_updated_at BEFORE UPDATE ON contacts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_campaigns_updated_at BEFORE UPDATE ON campaigns
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_outreach_updated_at BEFORE UPDATE ON outreach_log
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_templates_updated_at BEFORE UPDATE ON email_templates
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();