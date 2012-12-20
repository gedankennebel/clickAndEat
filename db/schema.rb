# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121205232306) do

  create_table "addresses", :force => true do |t|
    t.string "street"
    t.string "number"
    t.string "postcode"
    t.string "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "branches", :force => true do |t|
    t.text "info_text"
    t.text "opening_hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer "restaurant_id"
    t.integer "address_id"
  end

  create_table "item_categories", :force => true do |t|
    t.string "name"
    t.boolean "cookable"
    t.binary "default_picture"
    t.integer "restaurant_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string "name"
    t.decimal "price"
    t.integer "cooktime"
    t.binary "picture"
    t.integer "item_category_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string "description"
    t.integer "item_number"
  end

  create_table "order_items", :force => true do |t|
    t.boolean "cooked"
    t.boolean "served"
    t.integer "quantity"
    t.integer "item_id"
    t.integer "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.boolean "closed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer "table_id"
  end

  create_table "restaurants", :force => true do |t|
    t.string "name"
    t.binary "picture"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "restaurants_types", :id => false, :force => true do |t|
    t.integer "restaurant_id", :null => false
    t.integer "type_id", :null => false
  end

  add_index "restaurants_types", ["restaurant_id", "type_id"], :name => "index_restaurants_types_on_restaurant_id_and_type_id", :unique => true

  create_table "roles", :force => true do |t|
    t.string "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_user_accounts", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_account_id"
  end

  add_index "roles_user_accounts", ["role_id", "user_account_id"], :name => "index_roles_user_accounts_on_role_id_and_user_account_id", :unique => true

  create_table "tables", :force => true do |t|
    t.integer "table_number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer "branch_id"
  end

  create_table "types", :force => true do |t|
    t.string "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types_restaurants", :id => false, :force => true do |t|
    t.integer "type_id"
    t.integer "restaurant_id"
  end

  create_table "user_accounts", :force => true do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer "restaurant_id"
  end

end
