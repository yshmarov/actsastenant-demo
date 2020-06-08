class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :switch_tenant]

  def index
    @tenants = Tenant.all
  end

  def my
    @tenants = Tenant.includes(:members).where(members: {user: current_user}) #user sees only his tenants
    render 'index'
  end

  def switch_tenant
    #set_current_tenant(@tenant)
    ActsAsTenant.without_tenant do
      current_user.update_attribute(:tenant_id, @tenant.id)
    end
    redirect_to my_tenants_path, notice: "Tenant switched to #{current_user.tenant.name}"
  end

  def show
  end

  def new
    @tenant = Tenant.new
  end

  def edit
  end

  def create
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        @member = Member.create!(user: current_user, tenant: @tenant) #when a tenant is created, the creator becomes a member
        format.html { redirect_to @tenant, notice: 'Tenant was successfully created.' }
        format.json { render :show, status: :created, location: @tenant }
      else
        format.html { render :new }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: 'Tenant was successfully updated.' }
        format.json { render :show, status: :ok, location: @tenant }
      else
        format.html { render :edit }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to tenants_url, notice: 'Tenant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:name, :subdomain)
    end
end
