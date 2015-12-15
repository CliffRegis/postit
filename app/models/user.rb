class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false
  validates_presence_of :password, on: :create, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.username.gsub(" ","-").downcase
  end
end