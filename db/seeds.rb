#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)
#roles
user_role = Role.create!(name: 'user')
employee_role = Role.create!(name: 'employee')
manager_role = Role.create!(name: 'manager')

employee = UserAccount.create!(email: "emp@test.de", name: "Tom de Rofl", password: "test", password_confirmation: "test")
employee.roles << [employee_role, user_role]

waiter = UserAccount.create!(email: "waiter@test.de", name: "Waiter", password: "test", password_confirmation: "test")
waiter.roles << [employee_role, user_role]

cook = UserAccount.create!(email: "cook@test.de", name: "Cook", password: "test", password_confirmation: "test")
cook.roles << [employee_role, user_role]
manager = UserAccount.create!(email: "mgr@test.de", name: "Big Boss", password: "test", password_confirmation: "test")
manager.roles << [manager_role, user_role]
manager.save!

user = UserAccount.create!(email: "user@test.de", name: "Test User", password: "test", password_confirmation: "test")
user.roles << [user_role]
user.save!


#filter definitions
waiter.filter_definition = FilterDefinition.create!(cooked: true, served: false)
waiter.save!

cook.filter_definition = FilterDefinition.create!(cookable: true, cooked: false, served: false)
cook.save!

#restaurants
indian_type = Type.create!(name: "indian")
chinese_type = Type.create!(name: "chinese")
vietnamese_type = Type.create!(name: "vietnamese")
pakistani_type = Type.create!(name: "pakistani")
mexian_type = Type.create!(name: "mexican")

# restaurants info_text
pakistani_info_text = "The word tandoor came originally from the Middle East with the name deriving from the Babylonian word 'tinuru' from the Semitic word nar meaning fire. Hebrew and Arabic then made it tannur then tandur in Turkey, Central Asia and, finally Pakistan and India, who made it famous worldwide. Understandably, many people assume the tandoor to be native to Pakistan & India as evidence exists of early tandoors around 3000 BC. The traditional rounded-top tandoor oven is made of brick and clay. It's used to bake foods over direct heat produced from a smoky fire. The dough for the delicious Indian bread NAAN is slapped directly onto the oven's clay walls and left to bake until puffy and lightly browned. Meats cooked in the tall, rather cylindrical tandoor are usually skewered and thrust into the oven's heat, which is so intense (usually over 500°F) that it cooks a chicken half in less than 5 minutes..."
chinese_info_text = "Traditional Chinese food recipes tend to use lots of fresh vegetables and touches of salty sauces. Remember that very few Chinese food recipes use just one single list of ingredients. The exact combination changes from region to region and family to family."
mexian_info_text = "We are a relatively new restaurant that is excited to bring you the traditional flavors of Mexico. The talented chefs at El Charro treat you with exotic, delicious flavors of authentic Mexican tacos, nachos, and burritos. Everything is prepared fresh and with the finest ingredients, but the best part is how quickly we have it ready for you. We have everything from cheesy nachos to mouth-watering burritos, so you are sure to find something you enjoy any time of the day. The casual atmosphere, the friendly staff, and our wonderful Mexican cuisine provide the perfect setting for lunch or dinner."
indian_info_text = "Royal India - Indian restaurant in Munich"

#indian restaurant
indian_restaurant = Restaurant.new(name: "Royal India", info_text: indian_info_text)
indian_restaurant.avatar = File.open(Rails.root.join "public/seed_image/indian.jpeg")
indian_restaurant.types << indian_type

#chinese restaurant
chinese_restaurant = Restaurant.new(name: "Chopstix", info_text: chinese_info_text)
chinese_restaurant.avatar = File.open(Rails.root.join "public/seed_image/chinese.jpeg")
chinese_restaurant.types << [chinese_type, vietnamese_type]
chinese_restaurant.save!

#pakistani_restaurant
pakistani_restaurant = Restaurant.new(name: "Tandoori Palace", info_text: pakistani_info_text,)
pakistani_restaurant.avatar = File.open(Rails.root.join "public/seed_image/pakistan.png")
pakistani_restaurant.types << [pakistani_type, indian_type]

#mexian restaurant
mexican_restaurant = Restaurant.new(name: "El Charro", info_text: mexian_info_text)
mexican_restaurant.avatar = File.open(Rails.root.join "public/seed_image/mexican.jpg")
mexican_restaurant.types << [mexian_type]

#branches
address = Address.create!(city: "Munich", number: "117", postcode: "80339", street: "Westendstraße")
chinese_address = Address.create!(city: "Munich", number: "12", postcode: "80319", street: "Marktstraße")
pakistani_address1 = Address.create!(city: "Munich", number: "23", postcode: "81249", street: "Hofstraße")
pakistani_address2 = Address.create!(city: "Munich", number: "99", postcode: "80999", street: "Sendlingerstraße")
mexian_address = Address.create!(city: "Munich", number: "929", postcode: "87999", street: "Nachostraße")

mexian_branch = Branch.new(opening_hours: "daily from 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
mexian_branch.restaurant = mexican_restaurant

indian_branch = Branch.new(opening_hours: "daily from 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
indian_branch.restaurant = indian_restaurant

pakistani_branch1= Branch.new(opening_hours: "daily from 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
pakistani_branch2= Branch.new(opening_hours: "daily from 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
pakistani_branch1.restaurant = pakistani_restaurant
pakistani_branch2.restaurant = pakistani_restaurant

chinese_branch = Branch.new(opening_hours: "daily from 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
chinese_branch.restaurant = chinese_restaurant

indian_branch.address = address
pakistani_branch1.address = pakistani_address1
pakistani_branch2.address = pakistani_address2
chinese_branch.address = chinese_address
mexian_branch.address = mexian_address

mexian_branch.save!
indian_branch.save!
pakistani_branch1.save!
pakistani_branch2.save!
chinese_branch.save!

cook.branch = indian_branch
cook.save!
waiter.branch = indian_branch
waiter.save!

mexican_restaurant.branches [mexian_branch]
indian_restaurant.branches = [indian_branch]
pakistani_restaurant.branches = [pakistani_branch1, pakistani_branch2]
chinese_restaurant.branches = [chinese_branch]

mexican_restaurant.save!
indian_restaurant.save!
pakistani_restaurant.save!
chinese_restaurant.save!


manager.restaurant = indian_restaurant
manager.save!
employee.restaurant = indian_restaurant
employee.save!
waiter.restaurant = indian_restaurant
waiter.save!
cook.restaurant = indian_restaurant
cook.save!

#tables
table1 = Table.new(table_number: 1)
table1.branch = indian_branch
table1.save!

table2 = Table.new(table_number: 2)
table2.branch = indian_branch
table2.save!

table3 = Table.new(table_number: 3)
table3.branch = indian_branch
table3.save!

#item_categories
drinks = ItemCategory.new(cookable: 0, name: "Drinks")
drinks.restaurant=indian_restaurant
drinks.save!
food = ItemCategory.new(cookable: 1, name: "Food")
food.restaurant=indian_restaurant
food.save!
starters = ItemCategory.new(cookable: 1, name: "Starters")
starters.restaurant=indian_restaurant
starters.save!

#items
lassi = Item.new(cooktime: 5, name: "Mango Lassi", price: 2.9, item_number: 123, description: "Mango lassi is most commonly found in India and Pakistan though it is gaining popularity worldwide. It is made from yogurt, water and mango pulp.")
lassi.picture = File.open(Rails.root.join "app/assets/mango_lassi.jpg")
lassi.item_category = drinks
lassi.save!
jalfrezi = Item.new(cooktime: 25, name: "Chicken Jalfrezi", price: 10.9, item_number: 49, description: "Jalfrezi is a type of curry in which marinated pieces of meat or vegetables are fried in oil and spices to produce a dry, thick sauce. It is cooked with green chillies, with the result that a jalfrezi can range in heat from a medium dish to a very hot one. ")
jalfrezi.picture = File.open(Rails.root.join "app/assets/jalfrezi.jpg")
jalfrezi.item_category = food
jalfrezi.save!
biryani = Item.new(cooktime: 35, name: "Biryani", price: 13.9, item_number: 50, description: "Biryani is a set of rice-based foods made with spices, rice (usually basmati) and Chicken, mutton, fish, eggs or vegetables.")
biryani.picture = File.open(Rails.root.join "app/assets/biryani.jpg")
biryani.item_category = food
biryani.save!
pappad = Item.new(cooktime: 5, name: "Pappad", price: 2, item_number: 16, description: "Pappad is a thin, crisp Indian preparation sometimes described as a cracker. It is typically served as an accompaniment to a meal in India.")
pappad.picture = File.open(Rails.root.join "app/assets/pappad.jpg")
pappad.item_category = starters
pappad.save!

#order = Order.create!(table: table1)
#
#OrderItem.create!(order: order, item: pappad)
#OrderItem.create!(order: order, item: lassi)
#OrderItem.create!(order: order, item: jalfrezi)

# generate 20 test user, to make restaurants and testing around
i = 0
20.times do
  mail = i.to_s + "@lol.de"
  name = "Test Name " + i.to_s
  user = UserAccount.create!(email: mail, name: name, password: "lol", password_confirmation: "lol")
  user.roles << [user_role]
  user.save!
  i += 1
end








