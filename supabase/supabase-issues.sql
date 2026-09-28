-- Villa Caetano Issues — Supabase setup
-- Run this entire file in Supabase SQL Editor for the NEW project.

create extension if not exists pgcrypto;

create table if not exists public.issues (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  date_reported date not null default current_date,
  description text,
  priority text not null default 'Medium'
    check (priority in ('High','Medium','Low')),
  status text not null default 'Open'
    check (status in ('Open','In Progress','Resolved')),
  due_date date,
  resolution_note text,
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists issues_status_idx on public.issues(status);
create index if not exists issues_priority_idx on public.issues(priority);
create index if not exists issues_created_at_idx on public.issues(created_at desc);
create index if not exists issues_due_date_idx on public.issues(due_date);

create or replace function public.set_issues_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists issues_set_updated_at on public.issues;
create trigger issues_set_updated_at
before update on public.issues
for each row
execute function public.set_issues_updated_at();

alter table public.issues enable row level security;

-- These policies allow the browser pages to use the Supabase publishable/anon key.
-- IMPORTANT: this is appropriate for a private owner dashboard only if your
-- Supabase project is otherwise protected (for example with Auth).
-- If you later add Supabase Auth, replace these with authenticated-user policies.

drop policy if exists "issues_select" on public.issues;
create policy "issues_select"
on public.issues
for select
to anon, authenticated
using (true);

drop policy if exists "issues_insert" on public.issues;
create policy "issues_insert"
on public.issues
for insert
to anon, authenticated
with check (true);

drop policy if exists "issues_update" on public.issues;
create policy "issues_update"
on public.issues
for update
to anon, authenticated
using (true)
with check (true);

-- Optional: if you want browser-side deletion later, enable this policy.
-- The current Issues pages do not delete issues.
--
-- drop policy if exists "issues_delete" on public.issues;
-- create policy "issues_delete"
-- on public.issues
-- for delete
-- to anon, authenticated
-- using (true);

-- Quick test:
-- insert into public.issues (title, description, priority)
-- values ('Test issue', 'Delete or edit this after testing.', 'Low');
