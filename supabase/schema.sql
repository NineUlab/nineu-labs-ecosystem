-- NineU Labs initial database foundation
-- PostgreSQL / Supabase ready

create extension if not exists "uuid-ossp";

create table if not exists profiles (
  id uuid primary key default uuid_generate_v4(),
  email text not null unique,
  full_name text,
  phone text,
  country_code text,
  locale text,
  timezone text,
  role text not null default 'customer' check (role in ('admin', 'partner', 'customer')),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists partners (
  id uuid primary key default uuid_generate_v4(),
  profile_id uuid not null unique references profiles(id) on delete cascade,
  partner_code text not null unique,
  business_name text,
  partner_type text not null default 'individual' check (partner_type in ('individual', 'agency', 'strategic')),
  status text not null default 'pending' check (status in ('pending', 'active', 'suspended', 'blocked')),
  country text,
  region text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists partner_memberships (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid not null references partners(id) on delete cascade,
  plan_name text not null,
  price numeric(12,2) not null default 0,
  currency text not null default 'USD',
  billing_period text not null default 'monthly',
  start_date timestamptz not null default now(),
  expiry_date timestamptz,
  renewal_date timestamptz,
  payment_reference text,
  payment_status text not null default 'pending' check (payment_status in ('pending', 'paid', 'failed', 'refunded')),
  membership_status text not null default 'pending' check (membership_status in ('pending', 'active', 'expired', 'suspended', 'cancelled')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists customers (
  id uuid primary key default uuid_generate_v4(),
  profile_id uuid references profiles(id) on delete set null,
  company_name text,
  customer_type text default 'business',
  country text,
  region text,
  status text not null default 'active' check (status in ('active', 'inactive', 'suspended', 'cancelled')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists products (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  slug text not null unique,
  description text,
  status text not null default 'active' check (status in ('active', 'inactive', 'archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists product_packages (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  name text not null,
  slug text not null,
  setup_fee numeric(12,2) not null default 0,
  recurring_price numeric(12,2) not null default 0,
  billing_interval text not null default 'monthly',
  currency text not null default 'USD',
  status text not null default 'active' check (status in ('active', 'inactive', 'archived')),
  features jsonb default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(product_id, slug)
);

create table if not exists leads (
  id uuid primary key default uuid_generate_v4(),
  source text not null default 'company_generated' check (source in ('company_generated', 'partner_generated', 'campaign', 'referral', 'other')),
  external_ref text,
  customer_name text,
  company_name text,
  email text,
  phone text,
  country text,
  status text not null default 'new' check (status in ('new', 'available', 'assigned', 'contacted', 'interested', 'follow_up', 'won', 'lost', 'expired', 'returned')),
  product_id uuid references products(id),
  partner_id uuid references partners(id),
  assigned_partner_id uuid references partners(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists lead_assignments (
  id uuid primary key default uuid_generate_v4(),
  lead_id uuid not null references leads(id) on delete cascade,
  partner_id uuid not null references partners(id) on delete cascade,
  assignment_type text not null default 'automatic' check (assignment_type in ('automatic', 'manual', 'claim')),
  assignment_status text not null default 'active' check (assignment_status in ('active', 'expired', 'returned', 'closed')),
  claim_deadline timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists sales (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid references partners(id),
  customer_id uuid references customers(id),
  product_id uuid references products(id),
  package_id uuid references product_packages(id),
  lead_id uuid references leads(id),
  sale_reference text not null unique,
  sale_status text not null default 'pending' check (sale_status in ('pending', 'verified', 'cancelled', 'refunded', 'failed')),
  payment_status text not null default 'pending' check (payment_status in ('pending', 'paid', 'failed', 'refunded', 'disputed')),
  transaction_amount numeric(12,2) not null default 0,
  currency text not null default 'USD',
  partner_attribution text,
  setup_commission numeric(12,2) not null default 0,
  recurring_commission numeric(12,2) not null default 0,
  sale_date timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists product_payments (
  id uuid primary key default uuid_generate_v4(),
  customer_id uuid references customers(id) on delete cascade,
  sale_id uuid references sales(id) on delete set null,
  product_id uuid references products(id),
  package_id uuid references product_packages(id),
  provider text not null default 'paystack',
  provider_reference text,
  amount numeric(12,2) not null,
  currency text not null default 'USD',
  country text,
  status text not null default 'pending' check (status in ('pending', 'success', 'failed', 'refunded', 'disputed')),
  metadata jsonb default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists subscriptions (
  id uuid primary key default uuid_generate_v4(),
  customer_id uuid not null references customers(id) on delete cascade,
  product_id uuid not null references products(id),
  package_id uuid references product_packages(id),
  status text not null default 'active' check (status in ('active', 'trial', 'cancelled', 'expired', 'paused')),
  billing_interval text not null default 'monthly',
  amount numeric(12,2) not null default 0,
  currency text not null default 'USD',
  renewal_date timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists commission_rules (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid references products(id),
  package_id uuid references product_packages(id),
  partner_type text default 'individual' check (partner_type in ('individual', 'agency', 'strategic')),
  setup_percentage numeric(5,2) not null default 0,
  recurring_percentage numeric(5,2) not null default 0,
  notes text,
  status text not null default 'active' check (status in ('active', 'inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists commissions (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid not null references partners(id),
  sale_id uuid not null references sales(id),
  commission_type text not null check (commission_type in ('setup', 'recurring')),
  amount numeric(12,2) not null default 0,
  currency text not null default 'USD',
  status text not null default 'pending' check (status in ('pending', 'approved', 'available', 'paid', 'reversed', 'cancelled')),
  related_subscription_id uuid references subscriptions(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists wallets (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid not null unique references partners(id) on delete cascade,
  available_balance numeric(12,2) not null default 0,
  pending_balance numeric(12,2) not null default 0,
  total_earned numeric(12,2) not null default 0,
  total_withdrawn numeric(12,2) not null default 0,
  currency text not null default 'USD',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists wallet_transactions (
  id uuid primary key default uuid_generate_v4(),
  wallet_id uuid not null references wallets(id) on delete cascade,
  commission_id uuid references commissions(id),
  transaction_type text not null check (transaction_type in ('credit', 'debit', 'withdrawal')),
  amount numeric(12,2) not null,
  currency text not null default 'USD',
  status text not null default 'pending' check (status in ('pending', 'approved', 'paid', 'reversed', 'failed')),
  memo text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists withdrawals (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid not null references partners(id) on delete cascade,
  wallet_id uuid not null references wallets(id) on delete cascade,
  amount numeric(12,2) not null,
  currency text not null default 'USD',
  status text not null default 'requested' check (status in ('requested', 'under_review', 'approved', 'processing', 'paid', 'rejected', 'cancelled', 'failed')),
  payment_reference text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists marketing_resources (
  id uuid primary key default uuid_generate_v4(),
  partner_id uuid references partners(id) on delete set null,
  title text not null,
  resource_type text not null default 'template' check (resource_type in ('template', 'copy', 'social', 'whatsapp', 'video', 'creative')),
  content text,
  link text,
  status text not null default 'active' check (status in ('active', 'draft', 'archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists notifications (
  id uuid primary key default uuid_generate_v4(),
  profile_id uuid not null references profiles(id) on delete cascade,
  title text not null,
  body text not null,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists platform_settings (
  id uuid primary key default uuid_generate_v4(),
  key text not null unique,
  value jsonb not null,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists currencies (
  id uuid primary key default uuid_generate_v4(),
  code text not null unique,
  name text not null,
  symbol text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists audit_logs (
  id uuid primary key default uuid_generate_v4(),
  actor_profile_id uuid references profiles(id),
  entity_type text not null,
  entity_id uuid,
  action text not null,
  old_values jsonb,
  new_values jsonb,
  created_at timestamptz not null default now()
);

create index if not exists idx_partners_profile_id on partners(profile_id);
create index if not exists idx_partner_memberships_partner_id on partner_memberships(partner_id);
create index if not exists idx_sales_partner_id on sales(partner_id);
create index if not exists idx_sales_customer_id on sales(customer_id);
create index if not exists idx_commissions_partner_id on commissions(partner_id);
create index if not exists idx_leads_status on leads(status);
create index if not exists idx_leads_partner_id on leads(partner_id);
create index if not exists idx_wallet_transactions_wallet_id on wallet_transactions(wallet_id);
create index if not exists idx_withdrawals_partner_id on withdrawals(partner_id);

-- Example Row Level Security note:
-- In Supabase, each table should use policies such as:
-- - admin: full access
-- - partner: read own rows, write limited rows
-- - customer: read own data only
