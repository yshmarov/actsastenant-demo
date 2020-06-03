class Member < ApplicationRecord
  belongs_to :tenant
  belongs_to :user

  validates :tenant, presence: true
  #validates_uniqueness_of :user_id, scope: :tenant_id #if user present
  #validates_uniqueness_of :user_id, scope: :tenant_id, allow_blank: true #if we want members to exist without having a user (unfinished)

  acts_as_tenant(:tenant) #avaliable only if current_tenant is set
  validates_uniqueness_to_tenant :user_id #has to be under acts_as_tenant line

  def to_s
    #user.email
    [user.email, tenant.name].compact.join(', ')
  end
end
