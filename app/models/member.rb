class Member < ApplicationRecord
  belongs_to :tenant
  belongs_to :user

  validates :tenant, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id, allow_blank: true #if user present

  def to_s
    #user.email
    [user.email, tenant.name].compact.join(', ')
  end
end
