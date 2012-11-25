class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_and_belongs_to_many :roles
  belongs_to :restaurant

  validates_presence_of :email, :name, :password # validate as not null

  # validate email with RFC-822
  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    message: "Invalid mail syntax!"}
  validates :name, length: {minimum: 2, message: "A Name shoud contain at least 2 letters!"}

  # This regex stands for:
  # 6 to 20 characters string with at least one digit, one upper case letter, one lower case letter
  validates :password, format: {with: /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})/,
    message: "A password should match following pattern: 6 to 20 characters string with at least one digit, one upper case letter and one lower case letter!"}
  validates :password, confirmation: true #use password_confirmation in view to compare 
  validates :password_confirmation, presence: true #password_confirmation should not be null
 
  validates_associated :roles, :restaurant 
end
