class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  set_current_tenant_through_filter
  before_action :set_tenant

  def set_tenant
    #find_tenant = Tenant.first
    #current_tenant is a method set by acts_as_tenant. don't override it.
    #find_tenant = Tenant.find(10)
    #find_tenant = Tenant.find(params[:id])
    #set_current_tenant(find_tenant)

    #if Tenant.any?
    #  set_current_tenant(Tenant.first)
    #else
    #  set_current_tenant(nil)
    #end

    #set_current_tenant(Tenant.second)
    #set_current_tenant(nil)

    if current_user
      if current_user.tenant.present?
        #Tenant.find(10)
        #current_tenant = Tenant.find(params[:id])
        set_current_tenant(current_user.tenant)
      else
        set_current_tenant(nil)
      end
    end
  end
end
