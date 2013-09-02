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

ActiveRecord::Schema.define(:version => 20130712234456) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",     :limit => 23,                                :null => false
    t.datetime "updated_at",     :limit => 23,                                :null => false
    t.decimal  "price",                        :precision => 18, :scale => 0
    t.string   "billable_hours"
    t.string   "taxes"
    t.string   "lunch"
    t.string   "status"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :limit => 10
    t.text     "message"
    t.integer  "ticket_id",  :limit => 10
    t.datetime "created_at", :limit => 23, :null => false
    t.datetime "updated_at", :limit => 23, :null => false
  end

  add_index "comments", ["ticket_id"], :name => "index_comments_on_ticket_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :limit => 23, :null => false
    t.datetime "updated_at", :limit => 23, :null => false
  end

  create_table "service_orders", :force => true do |t|
    t.integer  "client_id",            :limit => 10
    t.string   "module"
    t.string   "project"
    t.date     "date",                 :limit => 10
    t.string   "reason"
    t.string   "requestor"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "non_billable_hours"
    t.string   "other_billable_hours"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at",           :limit => 23, :null => false
    t.datetime "updated_at",           :limit => 23, :null => false
    t.integer  "user_id",              :limit => 10
    t.string   "total_time"
  end

  add_index "service_orders", ["client_id"], :name => "index_service_orders_on_client_id"

  create_table "tickets", :force => true do |t|
    t.integer  "client_id",   :limit => 10
    t.string   "title"
    t.text     "description"
    t.string   "situation"
    t.integer  "user_id",     :limit => 10
    t.datetime "created_at",  :limit => 23, :null => false
    t.datetime "updated_at",  :limit => 23, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "mail"
    t.datetime "created_at",             :limit => 23,                 :null => false
    t.datetime "updated_at",             :limit => 23,                 :null => false
    t.integer  "role_id",                :limit => 10
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at", :limit => 23
    t.datetime "remember_created_at",    :limit => 23
    t.datetime "current_sign_in_at",     :limit => 23
    t.datetime "last_sign_in_at",        :limit => 23
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
