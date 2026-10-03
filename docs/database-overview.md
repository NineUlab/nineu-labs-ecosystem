# NineU Labs Foundation + Database Schema

## Stage 1 – Foundation
This repository initializes the production-ready project foundation for the NineU Labs ecosystem.

### Included
- Next.js application shell
- TypeScript configuration
- Responsive design basics
- Shared design tokens
- Documentation for brand and schema rules

### Deferred until later phases
- Full public website pages
- Partner registration flow
- Authentication and role enforcement
- Lead pool lifecycle
- Sales and commission workflows
- Wallet and payout processing
- Admin dashboard implementation

## Stage 2 – Database schema
The database design follows the Master Build Prompt with special emphasis on product, partner, membership, lead, sales, commission, and audit requirements.

### Baseline entity model
- profiles
- partners
- partner_memberships
- customers
- products
- product_packages
- leads
- lead_assignments
- sales
- product_payments
- subscriptions
- commission_rules
- commissions
- wallets
- wallet_transactions
- withdrawals
- marketing_resources
- notifications
- audit_logs
- platform_settings
- currencies

### Core design principles
- UUID-based identifiers
- Foreign keys and indexes on high-frequency lookups
- Timestamp fields for auditability
- Separate partner membership from customer product payments
- Separate lead assignment from final purchase attribution
- Commission records linked to sale, payment, subscription, and product package
- RLS-friendly structure for future Supabase implementation

## Example SQL schema
See `supabase/schema.sql` for the database foundation.
