class Restaurant < ActiveRecord::Base
  attr_accessible :name, :info_text, :avatar
  has_many :branches
  has_many :item_categories
  has_many :user_accounts
  has_and_belongs_to_many :types
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "150x150>"}

  validates :name, presence: true # validate name as not null
  validates :name, length: {minimum: 2, message: "A name shoud contain at least 2 letters!"} # a restaurant name must contain at least 2 letters

  def as_json(options = {})
    {
        name: self.name,
        item_categories: self.item_categories
    }
  end

  def self.create_new_restaurant restaurant, selected_types, extra_type
    restaurant = Restaurant.new restaurant
    set_types_to_restaurant restaurant, selected_types, extra_type
  end

  def self.update_restaurant restaurant_update, restaurant_id, selected_types, extra_type, avatar_flag
    restaurant = Restaurant.find_by_id restaurant_id
    if not selected_types.first.blank? or not extra_type.blank?
      restaurant.types.delete_all
      restaurant = set_types_to_restaurant restaurant, selected_types, extra_type
    end
    unless avatar_flag.blank?
      restaurant.avatar = nil
    end
    restaurant.update_attributes restaurant_update
  end

#private methods starts form here
  private

  def self.set_types_to_restaurant restaurant, selected_types, extra_type
    # dirty hack with hidden field for types, please forgive me! :(
    # if first element is blank
    # it means no types selected (only hidden field)
    unless selected_types.first.blank?
      # if types are selected then
      # the last element is always the hidden field, so cut it off
      types = selected_types.shift(selected_types.size-1)
      types.each do |name|
        add_type_to_restaurant(restaurant, name)
      end
    end
    # if user typed an extra type in form
    # e.g. if 'chinese' was not available to choose
    unless extra_type.blank?
      # insert new type into database, if not already has been
      Type.create_type extra_type.downcase
      # if no types selected as checkbox
      # choose extra_type directly
      unless types.blank?
        # check if extra_type is not same
        # as one of the selected one, before adding
        unless types.include? extra_type.downcase
          add_type_to_restaurant restaurant, extra_type.downcase
        end
      else
        add_type_to_restaurant restaurant, extra_type.downcase
      end
    end
    restaurant
  end

  # add types to a given restaurant
  def self.add_type_to_restaurant restaurant, type_name
    restaurant.types << Type.find_by_name(type_name)
  end

end
