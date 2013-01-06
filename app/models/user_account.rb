class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_and_belongs_to_many :roles
  belongs_to :restaurant
  belongs_to :filter_definition
  has_secure_password

  # validate email with RFC-822
  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                               message: "Invalid mail syntax!"}
  validates :name, length: {minimum: 2, message: "A name shoud contain at least 2 letters!"}

  validates_associated :roles, :restaurant

  MANAGER_ROLE = 'manager'

  def self.update_to_new_manager current_user, restaurant
    current_user.roles = Role.find_all_by_name(MANAGER_ROLE)
    current_user.restaurant = restaurant
    current_user.save!
  end

end
