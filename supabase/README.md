# Villa Caetano Issues — New Supabase setup

## 1. Create the Supabase project
Create a new Supabase project.

## 2. Create the database
Open:
Supabase → SQL Editor → New query

Paste the complete contents of `supabase-issues.sql` and run it.

This creates:
- `public.issues`
- priority/status constraints
- indexes
- automatic `updated_at`
- Row Level Security policies required by the current browser UI

## 3. Add the project credentials
Open `assets/supabase-config.js`.

Replace:
- `YOUR-PROJECT-REF`
- `YOUR_SUPABASE_PUBLISHABLE_KEY`

Use the project's browser-safe Publishable key from:
Supabase → Project Settings → API

Do NOT use a `service_role` or secret key in the HTML/JavaScript.

## 4. Keep this folder structure

dashboard/
├── index.html
├── issues.html
├── open-issues.html
├── assets/
│   ├── black-logo.png
│   ├── logo-white.png
│   └── supabase-config.js
└── supabase/
    ├── supabase-issues.sql
    └── README.md

## 5. What the Issues pages do

issues.html:
- Create issues
- Edit issues
- Set priority
- Set due date
- Set status
- Search/filter
- Resolve an issue
- Ask for a resolution note before resolving
- Keep resolved issues at the bottom

open-issues.html:
- Shows only unresolved issues
- Shows priority, status, dates and description
- Has a print button

The current pages do not require the old Villa Caetano JavaScript.
