# NineU Labs Ecosystem

This repository contains the initial foundation for the NineU Labs ecosystem as described in the Master Build Prompt, with the Brand Identity Prompt and Sales Performance Tracking Prompt incorporated into the project foundation.

## Stage 1 – Foundation
- Project bootstrap with Next.js and TypeScript
- Shared design token system based on the provided NineU Labs brand direction
- App shell and responsive structure
- Documentation for brand rules and database architecture

## Stage 2 – Database Schema
- Initial PostgreSQL / Supabase schema for profiles, partners, memberships, products, leads, sales, commissions, wallets, withdrawals, and audit logging
- Security and role foundation for admin, partner, and customer use cases

## Important notes
- The official NineU Labs logo assets were provided as image references in the project brief; this stage does not re-create or invent a new logo. The UI uses the brand name and approved brand direction without introducing a new asset.
- Full business workflow implementation remains intentionally deferred until the foundation and schema are reviewed and approved.

## Local development
```bash
npm install
npm run dev
```

## Production verification
```bash
npm run build
```
