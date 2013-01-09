class Message < ActiveRecord::Base
  attr_accessible :message_text, :message_type, :sender_account_id, :user_account_id
  belongs_to :user_account

  validates :message_text, length: {minimum: 2, message: "A message shoud contain at least 2 letters!"}
  validates_presence_of :user_account_id, :sender_account_id, :message_type

  #message type constants
  DECISION = 'decision'
  INFO = 'info'

  def self.create_new_decision_message sender_account_id, recipient_account_id, message_text
    Message.create!(message_text: message_text, message_type: DECISION, sender_account_id: sender_account_id, user_account_id: recipient_account_id)
  end

  def self.create_new_info_message sender_account_id, recipient_account_id, message_text
    Message.create!(message_text: message_text, message_type: INFO, sender_account_id: sender_account_id, user_account_id: recipient_account_id)
  end
end
