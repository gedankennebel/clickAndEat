class Restaurant < ActiveRecord::Base
  attr_accessible :name,:info_text, :avatar
  has_many :branches
  has_many :item_categories
  has_many :user_accounts
  has_and_belongs_to_many :types
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "150x150>"}

  validates :name, presence: true # validate name as not null
  validates :name, length: {minimum: 2} # a restaurant name must contain at least 2 letters

  def as_json(options = {})
    {
        name: self.name,
        item_categories: self.item_categories
    }
  end
end
