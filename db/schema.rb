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

ActiveRecord::Schema.define(:version => 20131205165031) do

  create_table "group_items", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "colour"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "membership_items", :force => true do |t|
    t.integer  "unit_item_id"
    t.integer  "membership_id"
    t.boolean  "unlimited",                                     :default => false
    t.decimal  "quantity_limit", :precision => 10, :scale => 0, :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "unit_items", :force => true do |t|
    t.integer  "group_item_id"
    t.string   "name",                                                                :null => false
    t.string   "item_key",                                                            :null => false
    t.string   "unit_name"
    t.text     "description"
    t.boolean  "unlimited",                                        :default => false
    t.decimal  "quantity_limit",    :precision => 10, :scale => 0, :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "unit_items", ["item_key", "unit_name"], :name => "index_unit_items_on_item_key_and_unit_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
