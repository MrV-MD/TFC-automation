# TFC Automation — Project State

> **Last updated:** 2026-02-09 (Session 1)
> **Update instructions:** At the end of each significant session, Claude will generate an updated version of this file. Download it and replace this file in the project knowledge base.

---

## Decisions Made

### Architecture
- **Database:** Supabase (PostgreSQL) — chosen over Notion for campaign logs and CRM due to relational queries, state machine support, and API access from n8n
- **Contact source (current):** Notion — will sync to Supabase; eventually the TFC app database will be the primary source
- **App database access:** Not available yet. Vasile will get access later. All current work uses mock data in Supabase
- **Mock data safety:** All fictional companies and `.example` domains (RFC 2606) — safe to run even if email sending is accidentally enabled

### Decisions Still Open
- **Email sending service:** Gmail/Google Workspace vs dedicated ESP (SendGrid, Resend, etc.) — recommendation leans toward Google Workspace for personal feel, TBD
- **AI model for email personalization:** Claude API vs OpenAI GPT-4o via n8n AI nodes — TBD
- **n8n hosting:** Self-hosted vs n8n Cloud — not yet discussed
- **Demo trigger type:** Manual button vs Notion trigger vs scheduled cron — not yet decided
- **Alex's current email provider:** Unknown — need to confirm

---

## Artifacts Created

### Database Schema (`01_schema.sql`) — DRAFTED, NOT YET DEPLOYED
6 tables designed and ready to run in a Supabase project:
- `contacts` — All club relationships (members, prospects, speakers, sponsors, partners)
- `events` — Club events with speakers (JSONB), access rules, capacity
- `campaigns` — Outreach campaigns tied to events or sales goals
- `outreach_log` — Per-contact email state machine (the core of the follow-up automation)
- `email_templates` — Template library with performance tracking
- `event_registrations` — Bridge table: who registered/attended which events

See the uploaded `01_schema.sql` file for full table definitions, indexes, and constraints.

### Mock Seed Data (`02_seed_data.sql`) — DRAFTED, NOT YET DEPLOYED
- **38 contacts:** 8 Premier, 10 Plus, 8 Core, 8 Prospects, 2 Speakers, 2 Sponsors/Partners
- **8 events:** 6 upcoming (mirrors TFC's real 2026 calendar) + 2 past
- **6 email templates:** Event announcement, 3 follow-ups (soft nudge → social proof → final value), membership upsell, welcome
- **1 active campaign:** Stablecoins Connect Series with sample outreach logs showing all states (converted, opened, sent, bounced)
- **Sample registrations:** Demonstrates campaign attribution and past attendance

See the uploaded `02_seed_data.sql` file for full data.

### Claude Project Setup
- **Project name:** TFC Automation
- **Project description:** Created
- **Custom instructions:** Created (stable context about TFC, tech stack, working style)

---

## Phase 1: Head of Sales Agent

### Completed
- [x] Database schema designed (6 tables — drafted, not yet deployed to Supabase)
- [x] Mock seed data created (38 contacts, 8 events, 6 templates, sample campaign)
- [x] Claude Project set up for ongoing collaboration

### Next Up
- [ ] Deploy schema and seed data to a Supabase project
- [ ] Finalize open decisions (email provider, AI model, trigger type)
- [ ] Design n8n Workflow 1: **Event Announcement Campaign**
  - Trigger → query eligible contacts → exclude already-registered → AI personalization → send email → log to outreach_log
- [ ] Design n8n Workflow 2: **Follow-Up Scheduler**
  - Cron → query due follow-ups from outreach_log → select next template → personalize → send → update log → mark exhausted if max reached
- [ ] Design n8n Workflow 3: **Reply/Bounce Handler**
  - Email webhook or polling → match to outreach_log → update status → update campaign stats → stop sequence if replied
- [ ] AI email personalization layer
- [ ] Campaign reporting

### Phase 2: Full CRM (Planned)
- Contact sync pipeline (Notion → Supabase, later App DB → Supabase)
- Engagement scoring automation
- Membership upsell workflows (Core → Plus, Plus → Premier)
- Welcome/onboarding sequences for new members

### Phase 3: Extended Capabilities (Future)
- Platform sales automation (sponsorships, partnerships)
- Re-engagement campaigns for inactive members
- Event capacity management and waitlist automation
- Integration with the TFC member app database

---

## Key Context for Future Sessions

- This work is preparing a **demo for Alex Pelin** (TFC founder). Outputs should be impressive and realistic, but designed to graduate to production.
- Alex is not a programmer. He prototyped the app in Replit to create a visual/functional spec for his engineering team.
- The TFC audience is senior fintech professionals. All automated communication must feel high-touch and personal.
- Vasile builds n8n workflows directly in the UI. Guidance should be architectural — not JSON exports.
- The architecture is designed to be **data-source agnostic** — sources and tools are swappable.