class Tenant < ApplicationRecord
  has_many :members
  has_many :users, through: :members

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end

  #before_create :generate_subdomain
  #def generate_subdomain
  #  unless self.subdomain.present?
  #    def generate_token
  #      loop do
  #        token = SecureRandom.hex(10)
  #        break token unless Tenant.where(subdomain: token).exists?
  #      end
  #    end
  #    self.subdomain = generate_token
  #  end
  #end
  validates :subdomain, presence: true, uniqueness: true, case_sensitive: false,
    length: { in: 3..100 }, 
    format: {with: %r{\A[a-z](?:[a-z0-9-]*[a-z0-9])?\z}i, message: "not a valid subdomain"},
    exclusion: { in: %w(app dashboard support blog billing help api www host admin), message: "%{value} is reserved." }
  #validates :subdomain, format: { with: /\A[\w\-]+\Z/i, message: "not a valid subdomain" }
  before_save do 
    self.subdomain.downcase!
  end
end
