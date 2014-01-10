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

ActiveRecord::Schema.define(:version => 20140110092429) do

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "author"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_offices", :force => true do |t|
    t.string "name"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "group_items", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "colour"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "membership_items", :force => true do |t|
    t.integer  "unit_item_id"
    t.integer  "membership_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "membership_prices", :force => true do |t|
    t.integer  "membership_id"
    t.decimal  "price",         :precision => 10, :scale => 0, :default => 0
    t.integer  "total_period",                                 :default => 0
    t.string   "periode_name",                                 :default => "day", :null => false
    t.boolean  "free",                                         :default => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "membership_prices", ["membership_id"], :name => "index_membership_prices_on_membership_id"

  create_table "memberships", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "slug"
    t.text     "description"
    t.date     "publish_on"
    t.date     "expire_on"
    t.integer  "version",      :default => 0
    t.integer  "position",     :default => 0
    t.boolean  "is_published", :default => false
    t.boolean  "is_featured",  :default => false
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "category_id"
  end

  add_index "memberships", ["name", "version"], :name => "index_memberships_on_name_and_version"
  add_index "memberships", ["slug"], :name => "index_memberships_on_slug", :unique => true

  create_table "offices", :force => true do |t|
    t.integer "category_office_id"
    t.integer "regional_id"
    t.string  "name"
    t.string  "address"
    t.string  "phone_area"
    t.text    "no_phone"
    t.text    "no_fax"
    t.string  "longitude"
    t.string  "latitude"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "membership_id"
    t.string   "title"
    t.integer  "order_id"
    t.integer  "quantity"
    t.decimal  "price",         :precision => 10, :scale => 0
    t.decimal  "subtotal",      :precision => 10, :scale => 0
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "orders", :force => true do |t|
    t.decimal  "total",                    :precision => 10, :scale => 0
    t.string   "session_id"
    t.string   "code_prefix"
    t.integer  "position"
    t.string   "code"
    t.integer  "orderable_id"
    t.string   "orderable_type"
    t.string   "status"
    t.integer  "period"
    t.string   "period_name"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "file_faktur_file_name"
    t.string   "file_faktur_content_type"
    t.integer  "file_faktur_file_size"
    t.datetime "file_faktur_updated_at"
  end

  create_table "payments", :force => true do |t|
    t.string   "transaction_no"
    t.string   "status"
    t.string   "bank_issuer"
    t.string   "credit_card"
    t.string   "order_id"
    t.string   "bank"
    t.text     "track_record"
    t.text     "access_record"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.decimal  "total",          :precision => 10, :scale => 0
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "no_phone"
    t.string   "no_hp"
    t.text     "address"
    t.string   "city"
    t.string   "province"
    t.string   "codepos"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
    t.string   "jenis_kelamin"
    t.date     "tanggal_lahir"
    t.string   "referal"
    t.string   "tipe_identitas"
    t.string   "no_identitas"
    t.string   "referal_id"
    t.text     "address_shipping"
    t.string   "file_ktp_file_name"
    t.string   "file_ktp_content_type"
    t.integer  "file_ktp_file_size"
    t.datetime "file_ktp_updated_at"
  end

  create_table "regionals", :force => true do |t|
    t.string "name"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "subscription_transactions", :force => true do |t|
    t.integer  "subscription_id"
    t.decimal  "amount",              :precision => 10, :scale => 0
    t.decimal  "fee",                 :precision => 10, :scale => 0
    t.decimal  "tax",                 :precision => 10, :scale => 0
    t.decimal  "discount",            :precision => 10, :scale => 0
    t.string   "status"
    t.string   "payment_gateway"
    t.text     "logs"
    t.string   "request_ip_address"
    t.string   "response_ip_address"
    t.datetime "deleted_at"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "subscription_transactions", ["subscription_id"], :name => "index_subscription_transactions_on_subscription_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "membership_id"
    t.integer  "membership_price_id"
    t.integer  "previous_membership_id"
    t.integer  "previous_membership_price_id"
    t.datetime "activated_at"
    t.datetime "next_bill_at"
    t.datetime "billed_at"
    t.datetime "canceled_at"
    t.string   "cancel_reason"
    t.datetime "deleted_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "subscriptions", ["membership_id"], :name => "index_subscriptions_on_membership_id"
  add_index "subscriptions", ["membership_price_id"], :name => "index_subscriptions_on_membership_price_id"
  add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"

  create_table "unit_items", :force => true do |t|
    t.integer  "group_item_id"
    t.string   "name",                                 :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "status_hd",         :default => false
    t.boolean  "free",              :default => false
  end

  add_index "unit_items", ["name"], :name => "index_unit_items_on_name"

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
    t.string   "code"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
