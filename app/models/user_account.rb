class UserAccount < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :lock
  has_and_belongs_to_many :roles
  belongs_to :restaurant
  belongs_to :filter_definition
  has_secure_password
  has_many :messages
  # TODO Najum current_branch

  # validate email with RFC-822
  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                               message: "Invalid mail syntax!"}
  validates :name, length: {minimum: 2, message: "A name shoud contain at least 2 letters!"}

  validates_associated :roles, :restaurant

  MANAGER_ROLE = 'manager'
  EMPLOYEE_ROLE = 'employee'

  def self.update_role_to_manager current_user, restaurant
    current_user.roles << Role.find_by_name(MANAGER_ROLE)
    current_user.restaurant = restaurant
    current_user.save!
  end

  def self.update_role_to_employee current_user, restaurant
    current_user.roles << Role.find_by_name(EMPLOYEE_ROLE)
    current_user.restaurant = restaurant
    current_user.save!
  end

  def self.send_employee_request_to_manager sender_account, restaurant_name
    restaurant = Restaurant.find_by_name restaurant_name
    if not restaurant.nil?
      message = 'A User with name '+ sender_account.name + ' wants access to your restaurant as employee'
      restaurant_manager_id = restaurant.user_accounts.last.id
      Message.create_new_decision_message sender_account.id, restaurant_manager_id, message
      lock_user_account_console sender_account
      return true
    else
      return false
    end
  end

  def self.accept_employee message_id
    message = Message.find message_id
    employee_account = UserAccount.find message.sender_account_id
    manager_account = UserAccount.find message.user_account_id
    update_role_to_employee employee_account, manager_account.restaurant
    unlock_user_account_console employee_account
    message.delete
    accept_message_text = manager_account.name + ", the manager of the restaurant "+ manager_account.restaurant.name + " accepted you as employee!"
    Message.create_new_info_message manager_account.id, employee_account.id, accept_message_text
  end

  def self.decline_employee message_id
    message = Message.find message_id
    employee_account = UserAccount.find message.sender_account_id
    manager_account = UserAccount.find message.user_account_id
    unlock_user_account_console employee_account
    message.delete
    decline_message_text = "Your application to restaurant "+ manager_account.restaurant.name + " has been rejected!"
    Message.create_new_info_message manager_account.id, employee_account.id, decline_message_text
  end

  private

  def self.lock_user_account_console user_account
    user_account.lock = true;
    user_account.save
  end

  def self.unlock_user_account_console user_account
    user_account.lock = false;
    user_account.save
  end
end
