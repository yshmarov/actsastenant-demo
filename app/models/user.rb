class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :invitable

  has_many :members
  has_many :tenants, through: :members

  #acts_as_tenant(:tenant) #will scope user list by tenant. tenant must exist
  belongs_to :tenant, required: false

  def to_s
    email
  end
end
