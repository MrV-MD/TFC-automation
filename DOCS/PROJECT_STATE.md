# TFC Automation — Project State

> **Last updated:** 2026-02-09 (Session 2)
> **Update instructions:** At the end of each significant session, Claude will generate an updated version of this file. Download it and replace this file in the project knowledge base.

---

## Decisions Made

### Architecture
- **Database:** Supabase (PostgreSQL) — chosen over Notion for campaign logs and CRM due to relational queries, state machine support, and API access from n8n
- **Contact source (current):** Notion — will sync to Supabase; eventually the TFC app database will be the primary source
- **App database access:** Not available yet. Vasile will get access later. All current work uses mock data in Supabase
- **Mock data safety:** All fictional companies and `.example` domains (RFC 2606) — safe to run even if email sending is accidentally enabled

### Schema Decisions (Finalized in Session 1)
- **Contacts — Removed:** `last_event_date`, `engagement_score`, `app_user_id`, `preferred_event_types`
- **Contacts — Kept:** `phone`, `linkedin_url`, `country`, `notes`, `tags`, `industry`, `events_attended`, `notion_id`
- **Events — Changed:** `price_nonmember`/`price_member` replaced with `pricing JSONB` to support multi-tier pricing (e.g. Delegation has 4 price tiers, Connect Series has 1, free events have none)
- **Campaigns — Removed:** `total_opened` (no open tracking)
- **Outreach Log — Removed:** `opened_at`, `clicked_at`, `scheduled_at`; simplified status enum to `pending`, `sent`, `replied`, `bounced`, `unsubscribed`, `converted`
- **Email Templates — Removed:** `avg_open_rate`
- **Tracking approach:** Reply tracking only. Open tracking intentionally skipped — unreliable with this senior executive audience (Apple Mail Privacy, corporate clients block pixels). Reply rate is the honest metric.

### Pricing Model Discovery
- TFC uses a **layered access model**, not simple ticket pricing
- Delegations: multi-tier (Delegation-Only $799, Premier $1,699, Plus $2,299, Core $2,499)
- Connect Series: single tier-specific ticket (e.g. Plus Members $599)
- Member Meetings/Breakfasts/Dinners: free for eligible members
- Membership tiers: Core (free, 10 credits/mo), Plus ($49/mo, 25 credits/mo), Premier ($299/mo, 50 credits/mo)
- Credits system exists in the app — purpose unconfirmed (likely connection requests between members). **Open question for Alex.**

### Decisions Still Open
- **Email sending service:** Gmail/Google Workspace vs dedicated ESP — recommendation leans toward Google Workspace for personal feel, TBD
- **AI model for email personalization:** Claude API vs OpenAI GPT-4o via n8n AI nodes — TBD
- **n8n hosting:** Self-hosted vs n8n Cloud — not yet discussed
- **Demo trigger type:** Manual button vs Notion trigger vs scheduled cron — not yet decided
- **Alex's current email provider:** Unknown — need to confirm
- **Credits system:** What are credits used for in the app? Confirm with Alex.

---

## Demo Plan

### Target Audience
Alex Pelin (TFC founder). Demo should be impressive and realistic — designed to graduate to production.

### Demo Components (Priority Order)

#### Component 1: Event Outreach & Follow-Up Workflow (50% effort)
The centerpiece. Triggered when a new event is created → fetches contacts → creates campaign → sends personalized emails → tracks sent/replied/registered → auto follow-ups for non-responders.
- **Two personalization approaches to demo side-by-side:**
  - Templates with smart placeholders (production-ready, stable, cost-efficient)
  - AI-generated personalization per contact (impressive, higher cost, optional upgrade)
- **Spam security:** Rate-limited sending, proper reply-to headers, never send to bounced/opted-out, Google Workspace for deliverability
- **Replies are NOT automated** — Alex replies personally. System notifies him of new replies.

#### Component 1.5: Campaign Dashboard (10% effort)
Visual UI showing campaign performance — contacted, replied, registered, pending follow-up. Pulls from the same Supabase data. Makes the system feel real and complete.
- Likely a React app or simple web dashboard
- Could be built via Claude Code as a separate project

#### Component 2: Telegram AI Assistant for Alex (30% effort)
Personal assistant bot with both proactive notifications and on-demand queries.
- **Build for demo:**
  - Campaign status on demand ("How's the Stablecoins event looking?")
  - Proactive alerts (new replies, campaign summaries)
  - Voice-to-action via transcription (voice message → transcribed → action)
  - Email drafting with approval flow (draft → Alex reviews → approves/edits → sends)
- **Mention but don't build for demo:**
  - Goal/project/initiative tracking (Phase 2 — dilutes the Head of Sales narrative)
- **Guardrails:** Approval flow before any send action, process safety, spam security

#### Component 3: Website Chat Agent (10% effort — Phase 2)
AI agent on the website for visitors/prospects. Advises on membership tiers, benefits, events, personalized recommendations.
- Alex expressed intention for this but as a later phase
- For demo: lightweight conceptual mockup showing a few scenarios
- Requires deep knowledge base prep (membership details, event specifics, FAQ)

### Demo Presentation Order
1. The Outreach Workflow — "Here's how your events get promoted automatically"
2. The Dashboard — "Here's how you see results at a glance"
3. The Telegram Bot — "And here's how you stay in control from your phone"
4. The Website Agent — "And in Phase 2, this is how inbound works"

---

## CRM Intention
Alex wants to move from Notion to a proper CRM. This could be a standalone app built via Claude Code. Must be secure (latest best practices: authentication, RLS, encrypted connections, audit trails). Treat as a separate future project that integrates with the same Supabase database.

---

## Artifacts Created

### Database Schema (`01_schema.sql`) — v2.0, DRAFTED, NOT YET DEPLOYED
6 tables with all Session 1 refinements applied:
- `contacts` — Members, prospects, speakers, sponsors, partners. Cleaned: no engagement_score, no app_user_id, no preferred_event_types.
- `events` — Club events with `pricing JSONB` for flexible multi-tier pricing, speakers JSONB, access rules, capacity.
- `campaigns` — Outreach campaigns with targeting, sequence config, reply-only stats.
- `outreach_log` — Per-contact email state machine. Simplified statuses (no open/click tracking).
- `email_templates` — Template library with reply rate tracking only.
- `event_registrations` — Bridge table for who registered/attended which events.

### Mock Seed Data (`02_seed_data.sql`) — v1.0, NEEDS UPDATE TO MATCH SCHEMA v2
- Seed data still references v1 schema (has open tracking fields, old pricing columns)
- **Action needed:** Regenerate seed data to match schema v2

### Claude Project Setup
- **Project name:** TFC Automation
- **Project description:** Created
- **Custom instructions:** Created (stable context about TFC, tech stack, working style)

---

## Phase Roadmap

### Phase 1: Head of Sales Agent — Event Outreach
- [x] Database schema designed (v2 — drafted, not yet deployed)
- [x] Mock seed data created (v1 — needs update to match schema v2)
- [x] Claude Project set up for ongoing collaboration
- [x] Demo plan defined and prioritized
- [x] Schema decisions finalized (all field-level reviews complete)
- [ ] **Update seed data to match schema v2**
- [ ] Deploy schema and seed data to Supabase
- [ ] Finalize open decisions (email provider, AI model, trigger type)
- [ ] Design n8n Workflow 1: **Event Announcement Campaign**
- [ ] Design n8n Workflow 2: **Follow-Up Scheduler**
- [ ] Design n8n Workflow 3: **Reply Handler + Alex Notification**
- [ ] AI email personalization layer (template vs AI side-by-side demo)
- [ ] Campaign dashboard UI

### Phase 1B: Telegram AI Assistant
- [ ] Telegram bot setup (Bot API + n8n webhook)
- [ ] Campaign status query flow
- [ ] Proactive alert flow (new replies, summaries)
- [ ] Voice message transcription (Whisper API or Claude API)
- [ ] Email drafting with approval flow
- [ ] Guardrails and safety checks

### Phase 2: Full CRM
- [ ] CRM app architecture (Claude Code project, secure by default)
- [ ] Contact sync pipeline (Notion → Supabase, later App DB → Supabase)
- [ ] Engagement scoring automation
- [ ] Membership upsell workflows (Core → Plus, Plus → Premier)
- [ ] Welcome/onboarding sequences for new members

### Phase 3: Extended Capabilities
- [ ] Website chat agent (membership advisor, event recommender)
- [ ] Platform sales automation (sponsorships, partnerships)
- [ ] Re-engagement campaigns for inactive members
- [ ] Event capacity management and waitlist automation
- [ ] Integration with the TFC member app database
- [ ] Credits system integration (once purpose is confirmed)

---

## Key Context for Future Sessions

- This work is preparing a **demo for Alex Pelin** (TFC founder). Outputs should be impressive and realistic, designed to graduate to production.
- Alex is **not a programmer**. He prototyped the app in Replit to create a visual/functional spec for his engineering team.
- The TFC audience is **senior fintech professionals** (VPs, CxOs, founders, government officials). All automated communication must feel high-touch and personal.
- Vasile builds n8n workflows directly in the UI. Guidance should be **architectural — not JSON exports**.
- The architecture is designed to be **data-source agnostic** — sources and tools are swappable.
- **Membership tiers:** Core (free, 10 credits/mo), Plus ($49/mo, 25 credits/mo), Premier ($299/mo, 50 credits/mo)
- **Event types:** Connect Series, Retreats, Delegations, Cyber Connect, Fintech Fest, Breakfasts, Dinners, Podcast Live, Webinars
- **Operating cities:** San Francisco, New York, Washington DC + international delegations (Amsterdam, Brussels, Tokyo, Lisbon)