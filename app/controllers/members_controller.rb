class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :resend_invitation]

  def index
    @members = Member.all
  end

  def invite
    current_tenant = Tenant.first
    email = params[:email]
    user_from_email = User.where(email: email).first
    if user_from_email.present?
      if Member.where(user: user_from_email, tenant: current_tenant).any?
        redirect_to members_path, alert: "The organisation #{current_tenant.name} already has a user with the email #{email}"
      else
        Member.create!(user: user_from_email, tenant: current_tenant)
        #email confirmation
        redirect_to members_path, notice: "#{email} was invited to join the organisation #{current_tenant.name}"
      end
    elsif user_from_email.nil?
      new_user = User.invite!(email: email)
      Member.create!(user: new_user, tenant: current_tenant)
      redirect_to members_path, notice: "#{email} was invited to join the organisation #{current_tenant.name}"
    end
  end

  def resend_invitation
    if @member.user.present?
      if @member.user.invitation_accepted?
  	  	redirect_to members_path, alert: "User already exists with an email #{@member.user.email}"
      else
        @member.user.invite!
  	  	redirect_to members_path, notice: "Invitation REsent to #{@member.user.email}"
      end
    end
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:tenant_id, :user_id)
    end
end
