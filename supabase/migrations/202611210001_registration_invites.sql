-- G&G Empréstimos | Migração inicial de convites
-- Execute no Supabase SQL Editor depois de revisar. Não apaga tabelas existentes.
create extension if not exists pgcrypto;

create table if not exists public.registration_invites (
  id uuid primary key default gen_random_uuid(),
  token_hash text not null unique,
  label text,
  expires_at timestamptz not null,
  max_uses integer not null default 1 check (max_uses = 1),
  uses_count integer not null default 0 check (uses_count between 0 and 1),
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  used_at timestamptz,
  revoked_at timestamptz
);

alter table public.registration_invites enable row level security;

drop policy if exists "Admins manage registration invites" on public.registration_invites;
create policy "Admins manage registration invites"
on public.registration_invites
for all
to authenticated
using (
  exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role in ('admin','staff')
  )
)
with check (
  exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role in ('admin','staff')
  )
);

create index if not exists registration_invites_created_at_idx
  on public.registration_invites (created_at desc);
create index if not exists registration_invites_expires_at_idx
  on public.registration_invites (expires_at);
