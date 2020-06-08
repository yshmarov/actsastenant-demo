ActsAsTenant.configure do |config|
  config.require_tenant = false
  #config.require_tenant = true
  #raise an ActsAsTenant::NoTenant error whenever a query is made without a tenant set
end