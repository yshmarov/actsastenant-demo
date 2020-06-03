class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  set_current_tenant_through_filter
  before_action :set_tenant

  def set_tenant
    current_tenant = Tenant.first
    #current_tenant = Tenant.find(10)
    #current_tenant = Tenant.find(params[:id])
    set_current_tenant(current_tenant)
  end
end
