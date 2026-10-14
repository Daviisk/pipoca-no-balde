-- Execute no SQL Editor de um projeto Supabase novo.
create extension if not exists pgcrypto;
create table public.admin_users (user_id uuid primary key references auth.users(id) on delete cascade);
create table public.products (id uuid primary key default gen_random_uuid(), name text not null, description text default '', category text not null default 'Gourmet', price numeric(10,2) not null check(price>0), image_url text, available boolean not null default true, created_at timestamptz not null default now());
create table public.orders (id uuid primary key default gen_random_uuid(),customer_name text not null,phone text not null,email text,method text not null check(method in ('uber','motoboy','pickup_scheduled','pickup_arranged')),address text,pickup_time text,notes text,total numeric(10,2) not null check(total>0),status text not null default 'pending' check(status in ('pending','paid','preparing','ready','out_for_delivery','completed','cancelled')),payment_id text,payment_preference_id text,created_at timestamptz not null default now());
create table public.order_items(id uuid primary key default gen_random_uuid(),order_id uuid not null references public.orders(id) on delete cascade,product_id uuid references public.products(id) on delete set null,product_name text not null,quantity integer not null check(quantity>0),unit_price numeric(10,2) not null check(unit_price>0));
alter table public.admin_users enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
create policy "Public available catalog" on public.products for select to anon,authenticated using (available=true);
-- Demais operações somente pela service role no servidor.
-- Crie o usuário em Authentication > Users e então execute:
-- insert into public.admin_users(user_id) values ('UUID-DO-USUARIO');
-- Produtos devem ser cadastrados com preços e fotos reais antes da publicação.
