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
#if Role.count == 0
employee_role = Role.create!(name: 'ROLE_EMPLOYEE')
manager_role = Role.create!(name: 'ROLE_MANAGER')
#end

#if UserAccount.count == 0
#user_accounts
#employee = UserAccount.create!(email: "employee@acme.com", name: "employee", password: "Employee1", password_confirmation: "Employee1")
#employee.roles << employee_role
#
#
#manager = UserAccount.create!(email:"manager@acme.com", name: "manager", password: "Manager1", password_confirmation: "Manager1")
#manager.roles << manager_role

#end

#restaurants
#if Restaurant.count == 0
type = Type.create!(name: "Indisch")
restaurant = Restaurant.new(name: "Royal India")
restaurant.types << type
restaurant.save!
#end

#branches
#if Branch.count == 0
address = Address.create!(city: "München", number: "117", postcode: "80339", street: "Westendstraße")

branch = Branch.new(info_text: "Royal India - Indian restaurant in Munich", opening_hours: "tgl. 11:30 – 14:30 Uhr, 17:30 – 23:00 Uhr")
branch.restaurant = restaurant
branch.address = address
branch.save!
#end

#tables
#if Table.count == 0
table1 = Table.new(table_number: 1)
table1.branch = branch
table1.save!

table2 = Table.new(table_number: 2)
table2.branch = branch
table2.save!

table3 = Table.new(table_number: 3)
table3.branch = branch
table3.save!
#end

#item_categories
#if ItemCategory.count == 0
drinks = ItemCategory.new(cookable: 0, name: "Getränke")
drinks.restaurant=restaurant
drinks.save!
food = ItemCategory.new(cookable: 1, name: "Hauptspeisen")
food.restaurant=restaurant
food.save!
starters = ItemCategory.new(cookable: 1, name: "Vorspeisen")
starters.restaurant=restaurant
starters.save!
#end

#items
#if Item.count == 0
lassi = Item.new(cooktime: 5, name: "Mango Lassi", price: 2.9, item_number: 123)
lassi.item_category = drinks
lassi.save!
jalfrezi = Item.new(cooktime: 25, name: "Chicken Jalfrezi", price: 10.9, item_number: 49)
jalfrezi.item_category = food
jalfrezi.save!
pappad = Item.new(cooktime: 5, name: "Pappad", price: 2, item_number: 16)
pappad.item_category = starters
pappad.save!
#end

order = Order.create!(table: table1)

OrderItem.create!(order: order, item: pappad)
OrderItem.create!(order: order, item: lassi)
OrderItem.create!(order: order, item: jalfrezi)






