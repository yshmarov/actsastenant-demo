# README

SaaS (organisations can have many members; organisation is billed)

haml
devise
simple_form
https://github.com/scambra/devise_invitable

1. Basic multitenant +
* Human can create user.+
* User can create many tenants.+
* When a user creates a tenant, he becomes a tenant member.+
* User can see only tenants where he is a member.+

1.1. Users
* Users can exist without belonging to a member or a tenant. +
* User table and user show pages exist. +

1.2. Tenants
* My tenants scope +
* All tenants scope +

1.2. devise_invitable - new user, new member +
* User can invite other users to become members of a tenant via email. +
* If a user with this email exists, we check if he is a member of this tenant. If he is not, he becomes a member. +
* If a user with this email does not exist, he gets an invitation email via devise invitable + he becomes a member. +
* #Note: devise_invitable has invitation on User model. If User accepts invitation once, he accepts all of them!

1.3. devise_invitable - new user, resend invitation +
* If the user has not confirmed his email, he can be re-invited +

1.3. OPTIONAL: member of a tenant can exist without user?
* devise_invitable - new user, old member
** A user can create a member without relation to another user in a tenant.
** A user can invite another user to use the member record via email.

1.4. subdomains
* When creating a tenant, a user can type in a subdomain. +
* Subdomains have restriction (permitted names, uniqueness). +
A user can edit his subdomain. +
If he does not type in a subdomain, a random one is assigned.
When a user select..

1.2. acts_as_tenant
Current_tenant is set by session/subdomain.
Members are scoped by current_tenant.
All models except User and Tenant are scoped by current_tenant.


Alternative Easy way (no subdomains)
* add a tenant_id to user table.
* when a user selects a tenant, his tenant_id is updated.
* now, he sees views scoped by this tenant.

2. Billing
* rails g migration CreatePlans name:string price:integer billing_period:integer
* Tenant belongs_to plan
* #what if the app is modular and Tenant can select a lot of different billed features?
* constraints {}

3. Roles
Roles are scoped by tenant.
When a user creates a tenant, he becomes the tenant admin.
Admin:
* Invite / delete members.
* Change member roles.
* Access to billing.
* Access to tenant settings.
Moderator:
* Everything except admin.
Viewer:
* Only view what moderator can do.

4. ransack, public_activity, friendly_id


find tenant by subdomain
https://medium.com/@praaveen/multi-tenancy-and-sub-domain-lvh-with-rails-f364c9dc0566


