class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest
  has_and_belongs_to_many :roles
  belongs_to :restaurant
  has_secure_password

  validates_presence_of :email, :name

  # validate email with RFC-822
  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                               message: "Invalid mail syntax!"}
  validates :name, length: {minimum: 2, message: "A Name shoud contain at least 2 letters!"}

  validates_associated :roles, :restaurant
end
