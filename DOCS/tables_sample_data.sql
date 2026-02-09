-- ============================================================
-- THE FINANCIAL CLUB — Mock Seed Data v2 (SAFE VERSION)
-- All companies, names, and emails are fully fictional.
-- All domains use .example (RFC 2606 reserved domain that
-- cannot resolve to real mailboxes — safe for testing).
-- ============================================================
-- Changes from v1:
--   CONTACTS: Removed engagement_score
--   EVENTS: Added pricing JSONB with realistic multi-tier data
--   CAMPAIGNS: Removed total_opened
--   OUTREACH_LOG: Removed opened_at; changed status 'opened'
--                 to 'sent' (no open tracking in v2)
-- ============================================================

-- ============================================================
-- CONTACTS: Mix of members (all tiers) and prospects
-- Reflects the fintech leader demographic of the actual club
-- ============================================================

INSERT INTO contacts (first_name, last_name, email, company, job_title, industry, membership_tier, contact_type, status, city, country, events_attended, tags) VALUES

-- PREMIER MEMBERS — The high-value inner circle
('Marcus', 'Chen', 'marcus.chen@novapay.example', 'NovaPay', 'CEO & Co-Founder', 'payments', 'premier', 'member', 'active', 'San Francisco', 'US', 12, ARRAY['founder','speaker','series-a']),
('Evelyn', 'Rodriguez', 'evelyn@hartcapital.example', 'Hart Capital Partners', 'Managing Partner', 'venture_capital', 'premier', 'member', 'active', 'New York', 'US', 9, ARRAY['investor','board-member']),
('David', 'Okonkwo', 'dokonkwo@unionfederal.example', 'Union Federal Bank', 'SVP Digital Innovation', 'banking', 'premier', 'member', 'active', 'Washington DC', 'US', 8, ARRAY['tradfi','enterprise']),
('Sarah', 'Lindqvist', 'sarah@blockshield.example', 'BlockShield', 'Founder & CEO', 'crypto_web3', 'premier', 'member', 'active', 'San Francisco', 'US', 11, ARRAY['founder','crypto','compliance']),
('James', 'Whitfield', 'jwhitfield@meridianlaw.example', 'Meridian Law Group', 'Partner, Fintech Practice', 'law', 'premier', 'member', 'active', 'New York', 'US', 7, ARRAY['legal','regulatory']),
('Amara', 'Osei', 'amara.osei@greenledger.example', 'GreenLedger', 'CEO', 'lending', 'premier', 'member', 'active', 'San Francisco', 'US', 10, ARRAY['founder','sustainability','series-b']),
('Robert', 'Nakamura', 'rnakamura@pacificrimvc.example', 'Pacific Rim Ventures', 'General Partner', 'venture_capital', 'premier', 'member', 'active', 'San Francisco', 'US', 6, ARRAY['investor','asia-focus']),
('Diana', 'Petrov', 'diana.petrov@cybersentinel.example', 'CyberSentinel', 'CISO', 'compliance', 'premier', 'member', 'active', 'Washington DC', 'US', 5, ARRAY['cybersecurity','government-adjacent']),

-- PLUS MEMBERS — Engaged professionals
('Tom', 'Baker', 'tom.baker@swiftsettle.example', 'SwiftSettle', 'Head of Product', 'payments', 'plus', 'member', 'active', 'San Francisco', 'US', 6, ARRAY['product','growth-stage']),
('Lisa', 'Moreau', 'lisa@shieldinsure.example', 'ShieldInsure Partners', 'Director of Strategy', 'insurance', 'plus', 'member', 'active', 'New York', 'US', 4, ARRAY['insurtech','strategy']),
('Ahmed', 'Hassan', 'ahmed.h@complianceai.example', 'ComplianceAI', 'CTO & Co-Founder', 'compliance', 'plus', 'member', 'active', 'Washington DC', 'US', 5, ARRAY['founder','ai','regtech']),
('Rachel', 'Kim', 'rachel.kim@heritageneo.example', 'Heritage NeoBank', 'VP of Partnerships', 'banking', 'plus', 'member', 'active', 'New York', 'US', 3, ARRAY['partnerships','neobank']),
('Carlos', 'Mendez', 'carlos@paylatam.example', 'PayLatam', 'CEO', 'payments', 'plus', 'member', 'active', 'San Francisco', 'US', 4, ARRAY['founder','latam','cross-border']),
('Priya', 'Sharma', 'priya.sharma@riskmatrix.example', 'RiskMatrix', 'Head of Data Science', 'risk_management', 'plus', 'member', 'active', 'San Francisco', 'US', 3, ARRAY['ai','risk','data']),
('Nathan', 'Brooks', 'nbrooks@pinnacleven.example', 'Pinnacle Venture Banking', 'Managing Director', 'banking', 'plus', 'member', 'active', 'San Francisco', 'US', 7, ARRAY['venture-banking','deals']),
('Grace', 'Liu', 'grace.liu@tokenbridge.example', 'TokenBridge', 'COO', 'crypto_web3', 'plus', 'member', 'active', 'New York', 'US', 4, ARRAY['stablecoins','operations']),
('Michael', 'Torres', 'mtorres@lendwise.example', 'LendWise', 'Chief Revenue Officer', 'lending', 'plus', 'member', 'active', 'New York', 'US', 2, ARRAY['revenue','embedded-finance']),
('Sophia', 'Anderson', 'sophia@fintechpolicy.example', 'Fintech Policy Council', 'Executive Director', 'government', 'plus', 'member', 'active', 'Washington DC', 'US', 5, ARRAY['policy','advocacy','nonprofit']),

-- CORE (FREE) MEMBERS — Potential upsell targets
('Kevin', 'Park', 'kevin.park@quicklend.example', 'QuickLend', 'VP of Engineering', 'lending', 'core', 'member', 'active', 'San Francisco', 'US', 1, ARRAY['engineering','early-stage']),
('Maria', 'Costa', 'maria.costa@europaypro.example', 'EuroPayPro', 'Head of US Expansion', 'payments', 'core', 'member', 'active', 'New York', 'US', 2, ARRAY['international','expansion']),
('Alex', 'Novak', 'alex.novak@defiprotocol.example', 'DeFi Protocol Labs', 'Founder', 'crypto_web3', 'core', 'member', 'active', 'San Francisco', 'US', 1, ARRAY['founder','defi','early-stage']),
('Jennifer', 'Walsh', 'jwalsh@summitadvisory.example', 'Summit Advisory Group', 'Senior Manager, Fintech Advisory', 'consulting', 'core', 'member', 'active', 'New York', 'US', 2, ARRAY['consulting','advisory']),
('Omar', 'Farah', 'omar.farah@sahelinvest.example', 'Sahel Investment Group', 'Partner', 'venture_capital', 'core', 'member', 'active', 'Washington DC', 'US', 1, ARRAY['investor','emerging-markets']),
('Christine', 'Dubois', 'cdubois@amlwatch.example', 'AML Watch', 'CEO', 'compliance', 'core', 'member', 'active', 'Washington DC', 'US', 0, ARRAY['founder','aml','new-member']),
('Ryan', 'Gallagher', 'ryan@paymentspulse.example', 'Payments Pulse', 'Editor-in-Chief', 'technology', 'core', 'member', 'active', 'San Francisco', 'US', 3, ARRAY['media','content','payments']),
('Samantha', 'Reed', 'samantha.reed@cutechfwd.example', 'CU TechForward', 'Chief Innovation Officer', 'banking', 'core', 'member', 'active', 'Washington DC', 'US', 1, ARRAY['credit-union','innovation']),

-- PROSPECTS — Interested but haven't joined yet
('Daniel', 'Wright', 'dwright@atlasbank.example', 'Atlas National Bank', 'VP, Emerging Payments', 'banking', 'prospect', 'prospect', 'active', 'New York', 'US', 0, ARRAY['enterprise','tier1-bank']),
('Yuki', 'Tanaka', 'yuki@tokyofintech.example', 'Tokyo Fintech Association', 'Director of Int''l Relations', 'technology', 'prospect', 'prospect', 'active', 'San Francisco', 'US', 0, ARRAY['japan','international']),
('Laura', 'Mitchell', 'laura.mitchell@apexpay.example', 'ApexPay Networks', 'Director, Innovation & Design', 'payments', 'prospect', 'prospect', 'active', 'San Francisco', 'US', 0, ARRAY['enterprise','card-networks']),
('Benjamin', 'Adler', 'ben.adler@quantumledger.example', 'QuantumLedger', 'Co-Founder & CTO', 'crypto_web3', 'prospect', 'prospect', 'active', 'New York', 'US', 0, ARRAY['founder','blockchain']),
('Isabelle', 'Fontaine', 'ifontaine@continentbank.example', 'Continental European Bank', 'Head of Digital Assets', 'banking', 'prospect', 'prospect', 'active', 'New York', 'US', 0, ARRAY['european-bank','digital-assets']),
('Derek', 'Simmons', 'derek.simmons@govfinreg.example', 'Federal Deposit & Insurance Agency', 'Senior Policy Advisor', 'government', 'prospect', 'prospect', 'active', 'Washington DC', 'US', 0, ARRAY['regulator','government','policy']),
('Nicole', 'Grant', 'nicole@wealthpilot.example', 'WealthPilot', 'VP of Growth', 'technology', 'prospect', 'prospect', 'active', 'San Francisco', 'US', 0, ARRAY['wealthtech','growth']),
('Patrick', 'O''Brien', 'pobrien@sterlingcap.example', 'Sterling Capital Group', 'Executive Director, Fintech Strategy', 'banking', 'prospect', 'prospect', 'active', 'New York', 'US', 0, ARRAY['enterprise','strategy']),

-- SPEAKERS (some overlap with members)
('Catherine', 'Wells', 'cwells@govtreasury.example', 'U.S. Department of Financial Policy', 'Deputy Assistant Secretary', 'government', 'prospect', 'speaker', 'active', 'Washington DC', 'US', 2, ARRAY['government','speaker','policy']),
('Raj', 'Patel', 'raj@crossborderpay.example', 'CrossBorder Payments Inc', 'CEO & Founder', 'payments', 'plus', 'speaker', 'active', 'San Francisco', 'US', 5, ARRAY['founder','speaker','cross-border']),

-- SPONSORS / PARTNERS
('Victoria', 'Huang', 'vhuang@westcoastvenbank.example', 'WestCoast Venture Bank', 'Head of Fintech Banking', 'banking', 'premier', 'sponsor', 'active', 'San Francisco', 'US', 8, ARRAY['sponsor','partner']),
('Brian', 'McCarthy', 'brian@fintechconf.example', 'Global Fintech Summit', 'VP Partnerships', 'technology', 'core', 'partner', 'active', 'New York', 'US', 3, ARRAY['partner','conference','events']);


-- ============================================================
-- EVENTS: Mirrors the actual 2026 Financial Club schedule
-- Now with pricing JSONB for multi-tier pricing model
-- ============================================================

INSERT INTO events (name, slug, event_type, description, date_start, date_end, city, venue, capacity, access_type, eligible_tiers, pricing, speakers, agenda_summary, status, registration_url) VALUES

-- Upcoming events (perfect for demo campaigns)
(
    'Connect Series: The Future of Stablecoins',
    'connect-stablecoins-q1-2026',
    'connect_series',
    'An invite-only gathering for decision makers in the Digital Payment and Stablecoin space. Join leaders from traditional finance, crypto, and government to explore regulation, adoption, and infrastructure for the next generation of digital payments.',
    '2026-03-15 18:00:00-05',
    '2026-03-15 21:00:00-05',
    'New York',
    'The Skylark, Midtown',
    45,
    'members_only',
    '{plus,premier}',
    '{"plus": {"price": 599, "label": "Plus Members", "includes": "Reception, panels, roundtable, networking dinner"}, "premier": {"price": 0, "label": "Premier Members", "includes": "Complimentary VIP access with reserved seating"}}',
    '[{"name":"Catherine Wells","title":"Deputy Assistant Secretary","company":"U.S. Department of Financial Policy","topic":"Regulatory Landscape for Stablecoins"},{"name":"Grace Liu","title":"COO","company":"TokenBridge","topic":"Infrastructure Challenges at Scale"},{"name":"Marcus Chen","title":"CEO","company":"NovaPay","topic":"Stablecoins in B2B Payments"}]',
    'Opening remarks and networking reception (6:00-6:30 PM). Panel: Regulatory Landscape (6:30-7:15 PM). Fireside chat: Infrastructure at Scale (7:15-7:45 PM). Networking dinner (7:45-9:00 PM).',
    'registration_open',
    'https://www.app.financialclub.com/events/connect-stablecoins-q1-2026'
),
(
    'Financial Club Breakfast: AI in Risk Management',
    'breakfast-ai-risk-sf-2026',
    'breakfast',
    'An intimate breakfast conversation exploring how artificial intelligence is transforming risk assessment, fraud detection, and compliance monitoring across financial services.',
    '2026-03-28 08:00:00-07',
    '2026-03-28 10:30:00-07',
    'San Francisco',
    'The Battery, SF',
    25,
    'members_only',
    '{core,plus,premier}',
    '{}',
    '[{"name":"Priya Sharma","title":"Head of Data Science","company":"RiskMatrix","topic":"ML Models for Real-Time Fraud Detection"},{"name":"Ahmed Hassan","title":"CTO","company":"ComplianceAI","topic":"Building AI-First Compliance Programs"}]',
    'Breakfast and networking (8:00-8:30 AM). Keynote: AI-First Compliance (8:30-9:00 AM). Roundtable discussion (9:00-10:00 AM). Closing remarks (10:00-10:30 AM).',
    'announced',
    'https://www.app.financialclub.com/events/breakfast-ai-risk-sf-2026'
),
(
    'Cyber Connect US 2026',
    'cyber-connect-us-2026',
    'cyber_connect',
    'A private, high-level summit convening heads of state-level cybercrime investigation and enforcement, federal agencies, and senior leaders from the private sector to strengthen cybersecurity coordination across the United States.',
    '2026-05-11 09:00:00-04',
    '2026-05-12 17:00:00-04',
    'Washington DC',
    'The Watergate Hotel',
    120,
    'application_only',
    '{plus,premier}',
    '{"plus": {"price": 1299, "label": "Plus Members"}, "premier": {"price": 799, "label": "Premier Members"}, "nonmember": {"price": 1999, "label": "Non-Member (Application Required)"}}',
    '[{"name":"Diana Petrov","title":"CISO","company":"CyberSentinel","topic":"Threat Intelligence Sharing Frameworks"},{"name":"Catherine Wells","title":"Deputy Asst Secretary","company":"U.S. Dept of Financial Policy","topic":"National Cybersecurity Strategy Update"}]',
    'Day 1: Opening keynotes, threat landscape briefings, breakout working groups. Day 2: Cross-sector collaboration workshops, policy roundtables, closing summit.',
    'announced',
    'https://www.financialclub.com/connect-series#cyber'
),
(
    'Fintech Fest 2.0',
    'fintech-fest-2026',
    'fintech_fest',
    'The only open-air fintech experience designed for real connection. Limited free attendance for Financial Club members.',
    '2026-05-28 10:00:00-07',
    '2026-05-28 20:00:00-07',
    'San Francisco',
    'Presidio Tunnel Tops',
    300,
    'application_only',
    '{core,plus,premier}',
    '{"core": {"price": 149, "label": "Core Members"}, "plus": {"price": 0, "label": "Plus Members", "includes": "Free attendance"}, "premier": {"price": 0, "label": "Premier Members", "includes": "Free VIP attendance with backstage access"}, "nonmember": {"price": 299, "label": "General Admission (Application Required)"}}',
    '[]',
    'All-day open-air experience. Morning: keynotes and panels. Afternoon: startup showcases and networking. Evening: sunset reception and live music.',
    'draft',
    'https://fintechfest.co/#passes'
),
(
    'International Delegation: Amsterdam & Brussels',
    'delegation-europe-2026',
    'delegation',
    'The Financial Club''s International Delegation during Money20/20 Europe. Exclusive member dinners, regulatory meetings in Brussels, and curated networking across Amsterdam.',
    '2026-06-02 09:00:00+02',
    '2026-06-05 18:00:00+02',
    'Amsterdam',
    'Multiple venues',
    40,
    'members_only',
    '{plus,premier}',
    '{"delegation_only": {"price": 799, "label": "Delegation-Only Access", "note": "For attendees who already hold a Money20/20 Europe pass"}, "premier": {"price": 1699, "label": "Premier Delegate"}, "plus": {"price": 2299, "label": "Plus Delegate"}, "core": {"price": 2499, "label": "Core Delegate"}}',
    '[]',
    'Day 1-2: Amsterdam — Member dinners, side events, fintech tours. Day 3-4: Brussels — EU regulatory briefings, meetings with European Commission officials, policy roundtable.',
    'draft',
    NULL
),
(
    '6th Annual Fintech Retreat',
    'fintech-retreat-2026',
    'retreat',
    'The flagship annual gathering for Financial Club members and selected guests. Three days of intimate conversations, outdoor activities, and relationship building in a stunning natural setting.',
    '2026-09-17 14:00:00-07',
    '2026-09-20 12:00:00-07',
    'Napa Valley',
    'Meadowood Resort',
    80,
    'application_only',
    '{plus,premier}',
    '{"premier": {"price": 1500, "label": "Premier Members", "note": "75% discount applied"}, "plus": {"price": 3600, "label": "Plus Members", "note": "40% discount applied"}, "core": {"price": 5100, "label": "Core Members", "note": "15% discount applied"}, "nonmember": {"price": 6000, "label": "Non-Members (Application Required)"}}',
    '[]',
    'Day 1: Arrival, welcome reception, keynote dinner. Day 2: Morning panels, afternoon vineyard experience, evening fireside chats. Day 3: Workshops, closing brunch.',
    'draft',
    'https://fintechretreat.com/'
),

-- Past events (for historical context in the data)
(
    'Connect Series: Digital Assets & TradFi Convergence',
    'connect-digital-assets-2025',
    'connect_series',
    'Exploring the intersection of traditional financial institutions and digital asset infrastructure.',
    '2025-11-12 18:00:00-05',
    '2025-11-12 21:00:00-05',
    'New York',
    'Spring Studios',
    50,
    'members_only',
    '{plus,premier}',
    '{"plus": {"price": 499, "label": "Plus Members"}, "premier": {"price": 0, "label": "Premier Members"}}',
    '[{"name":"Evelyn Rodriguez","title":"Managing Partner","company":"Hart Capital Partners","topic":"Institutional Allocation to Digital Assets"}]',
    NULL,
    'completed',
    NULL
),
(
    '5th Annual DeFi Retreat',
    'defi-retreat-2025',
    'retreat',
    'The annual DeFi-focused retreat bringing together builders, investors, and regulators.',
    '2025-10-02 14:00:00-07',
    '2025-10-05 12:00:00-07',
    'Lake Tahoe',
    'Edgewood Tahoe Resort',
    60,
    'application_only',
    '{plus,premier}',
    '{"premier": {"price": 1200, "label": "Premier Members"}, "plus": {"price": 3000, "label": "Plus Members"}, "nonmember": {"price": 5000, "label": "Non-Members"}}',
    '[]',
    NULL,
    'completed',
    NULL
);


-- ============================================================
-- EMAIL TEMPLATES: Outreach sequences for the agent
-- ============================================================

INSERT INTO email_templates (name, category, subject_template, body_template) VALUES

(
    'event_announce_exclusive',
    'event_announcement',
    'You''re Invited: {{event_name}} — {{event_city}}',
    'Hi {{first_name}},

I wanted to personally reach out about an upcoming gathering I think you''d find valuable.

{{event_name}} is happening on {{event_date}} in {{event_city}}, and given your work at {{company}} in {{industry}}, I thought this would be right up your alley.

{{event_description}}

{{#if speakers}}Joining us will be:
{{speakers_formatted}}{{/if}}

{{#if agenda}}Here''s what we have planned:
{{agenda}}{{/if}}

As a {{membership_tier}} member, {{access_note}}.

Would love to have you there. Let me know if you have any questions.

Best,
Alex Pelin
Founder, The Financial Club'
),

(
    'followup_1_soft_nudge',
    'follow_up_1',
    'Quick follow-up: {{event_name}}',
    'Hi {{first_name}},

Just circling back on {{event_name}} on {{event_date}}. We''re seeing strong interest and I wanted to make sure you had a chance to review before spots fill up.

{{#if speakers}}As a reminder, {{speaker_highlight}} will be joining us to discuss {{topic_highlight}}.{{/if}}

A few members from {{industry_peers}} are already confirmed — could be a great chance to connect.

Here''s the quick link to register: {{registration_url}}

Happy to chat if you have questions.

Best,
Alex'
),

(
    'followup_2_social_proof',
    'follow_up_2',
    '{{event_name}} — only {{spots_remaining}} spots left',
    'Hi {{first_name}},

Quick update — {{event_name}} is filling up quickly. We''re down to the last {{spots_remaining}} spots.

I mention this because the conversations at these gatherings tend to be the kind you won''t find at larger conferences — intimate, high-level, and directly relevant to what you''re building at {{company}}.

{{#if testimonial}}As {{testimonial_author}} from {{testimonial_company}} put it: "{{testimonial_quote}}"{{/if}}

If you''d like to join, here''s the link: {{registration_url}}

No pressure at all — just didn''t want you to miss out.

Best,
Alex'
),

(
    'followup_3_final_value',
    'follow_up_3',
    'Last chance: {{event_name}} this {{event_weekday}}',
    'Hi {{first_name}},

Last note from me about {{event_name}} — the event is this {{event_weekday}} and we have just a handful of spots remaining.

I won''t keep reaching out about this one, but I did want to share that we''ve confirmed attendees from {{notable_companies}} — the room is going to be exceptional.

If the timing doesn''t work this time, no worries at all. We have several more events coming up this quarter that might be a better fit.

Hope to see you there: {{registration_url}}

Best,
Alex'
),

(
    'upsell_core_to_plus',
    'membership_upsell',
    'Unlock more from The Financial Club',
    'Hi {{first_name}},

I noticed you''ve been engaging with the club and attended {{events_attended}} event(s) — glad to have you as part of the community.

I wanted to let you know about a few things you might be missing as a Core member. With Plus membership ($49/mo), you''d get:

- Free access to all Financial Club meetings (vs. select meetings now)
- 40% discount at the Fintech and DeFi Retreats
- Access to our private member discussion channel
- Live recordings and Q&A from Market Reads Podcast
- Priority access to Retreat passes

Many of our most active members started on Core and found that upgrading paid for itself within a single event discount.

Happy to chat if you have any questions about whether Plus would be a fit.

Best,
Alex Pelin
Founder, The Financial Club'
),

(
    'welcome_new_member',
    'welcome',
    'Welcome to The Financial Club, {{first_name}}!',
    'Hi {{first_name}},

Welcome aboard — I''m thrilled to have you join The Financial Club.

Here''s what to do first:
1. Download our member app and complete your profile
2. Check out the upcoming events calendar
3. Join the member discussion channel (Plus & Premier members)

Your membership gives you access to {{tier_benefits_summary}}.

Our next gathering is {{next_event_name}} on {{next_event_date}} in {{next_event_city}} — I''d love to see you there.

If there''s a specific introduction I can make or a topic you''re keen to explore, just reply to this email. That''s what the club is for.

Best,
Alex Pelin
Founder, The Financial Club'
);


-- ============================================================
-- SAMPLE CAMPAIGN: Stablecoins Connect Series
-- ============================================================

INSERT INTO campaigns (event_id, name, campaign_type, target_segment, max_follow_ups, follow_up_interval_days, status, total_contacts, total_sent, total_replied, started_at)
SELECT
    e.id,
    'Stablecoins Connect Series — Full Member Outreach',
    'event_announcement',
    '{"membership_tier": ["plus", "premier"], "contact_type": ["member", "speaker"], "status": ["active"]}',
    3,
    3,
    'active',
    18,
    18,
    2,
    '2026-02-01 10:00:00-05'
FROM events e WHERE e.slug = 'connect-stablecoins-q1-2026';


-- ============================================================
-- SAMPLE OUTREACH LOG: State machine in action
-- (No open tracking — only sent, replied, bounced, converted)
-- ============================================================

-- Marcus Chen (Premier) — Replied immediately → CONVERTED
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, replied_at)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'converted',
    '2026-02-01 10:05:00-05', '2026-02-01 11:15:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'marcus.chen@novapay.example';

-- Evelyn Rodriguez (Premier) — Sent, no reply yet → needs follow-up 1
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, next_followup_at)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'sent',
    '2026-02-01 10:05:00-05', '2026-02-04 10:00:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'evelyn@hartcapital.example';

-- Tom Baker (Plus) — Sent, no reply → needs follow-up 1
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, next_followup_at)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'sent',
    '2026-02-01 10:05:00-05', '2026-02-04 10:00:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'tom.baker@swiftsettle.example';

-- Grace Liu (Plus, Speaker) — Replied YES → CONVERTED
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, replied_at)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'converted',
    '2026-02-01 10:05:00-05', '2026-02-01 12:45:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'grace.liu@tokenbridge.example';

-- Michael Torres (Plus) — Initial sent, then follow-up 1 sent, no reply → needs follow-up 2
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, next_followup_at)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'sent',
    '2026-02-01 10:05:00-05', '2026-02-04 10:00:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'mtorres@lendwise.example';

INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, next_followup_at)
SELECT c.id, ct.id, 2, 'Quick follow-up: Connect Series: The Future of Stablecoins', 'followup_1_soft_nudge', 'sent',
    '2026-02-04 10:05:00-05', '2026-02-07 10:00:00-05'
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'mtorres@lendwise.example';

-- Lisa Moreau (Plus) — Bounced
INSERT INTO outreach_log (campaign_id, contact_id, sequence_step, email_subject, template_used, status, sent_at, followup_exhausted)
SELECT c.id, ct.id, 1, 'You''re Invited: Connect Series: The Future of Stablecoins — New York', 'event_announce_exclusive', 'bounced',
    '2026-02-01 10:05:00-05', TRUE
FROM campaigns c, contacts ct WHERE c.name LIKE 'Stablecoins%' AND ct.email = 'lisa@shieldinsure.example';


-- ============================================================
-- SAMPLE EVENT REGISTRATIONS
-- ============================================================

INSERT INTO event_registrations (event_id, contact_id, registration_status, source, campaign_id)
SELECT e.id, ct.id, 'confirmed', 'email_campaign', c.id
FROM events e, contacts ct, campaigns c
WHERE e.slug = 'connect-stablecoins-q1-2026'
AND ct.email = 'marcus.chen@novapay.example'
AND c.name LIKE 'Stablecoins%';

INSERT INTO event_registrations (event_id, contact_id, registration_status, source, campaign_id)
SELECT e.id, ct.id, 'confirmed', 'email_campaign', c.id
FROM events e, contacts ct, campaigns c
WHERE e.slug = 'connect-stablecoins-q1-2026'
AND ct.email = 'grace.liu@tokenbridge.example'
AND c.name LIKE 'Stablecoins%';

INSERT INTO event_registrations (event_id, contact_id, registration_status, source, registered_at, attended_at)
SELECT e.id, ct.id, 'attended', 'direct', '2025-10-28', '2025-11-12'
FROM events e, contacts ct
WHERE e.slug = 'connect-digital-assets-2025'
AND ct.email IN ('marcus.chen@novapay.example', 'evelyn@hartcapital.example', 'sarah@blockshield.example', 'amara.osei@greenledger.example', 'nbrooks@pinnacleven.example');