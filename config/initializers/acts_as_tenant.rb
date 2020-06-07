ActsAsTenant.configure do |config|
  #raise an ActsAsTenant::NoTenant error whenever a query is made without a tenant set
  config.require_tenant = false
  #config.require_tenant = true
end