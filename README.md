# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

haml
devise
simple_form
https://github.com/scambra/devise_invitable

1. Basic multitenant
Human can create user.+
User can create many tenants.+
When a user creates a tenant, he becomes a tenant member.+
User can see only tenants where he is a member.+

1.2. acts_as_tenant
Current_tenant is set by session/subdomain.
Members are scoped by current_tenant.
All models except User and Tenant are scoped by current_tenant.

1.3. devise_invitable
User can invite other users to become members of a tenant via email. ***
Note: devise_invitable has invitation on User model. If User accepts invitation once, he accepts all of them!

1.4. subdomains

2. Tenant belongs_to plan

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