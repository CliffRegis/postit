class User < ActiveRecord::Base
  include Sluggable
  
  has_many :posts
  has_many :comments

  has_secure_password validations: false
  validates_presence_of :password, on: :create, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true

  sluggable_column :username

end