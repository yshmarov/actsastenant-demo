class Tenant < ApplicationRecord
  has_many :members
  has_many :users, through: :members

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
