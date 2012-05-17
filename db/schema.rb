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

ActiveRecord::Schema.define(:version => 20120516204210) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "github_accounts", :force => true do |t|
    t.integer  "authentication_id"
    t.integer  "uid"
    t.string   "nickname"
    t.string   "last_status_id",    :default => "0", :null => false
    t.string   "string",            :default => "0", :null => false
    t.string   "image"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "growls", :force => true do |t|
    t.string   "type"
    t.text     "comment"
    t.text     "link"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "regrowled_from_id"
  end

  add_index "growls", ["created_at"], :name => "index_growls_on_created_at"

  create_table "meta_data", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "thumbnail_url"
    t.integer  "growl_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "regrowls", :force => true do |t|
    t.integer  "user_id"
    t.integer  "growl_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "regrowls", ["created_at"], :name => "index_regrowls_on_created_at"
  add_index "regrowls", ["user_id", "growl_id"], :name => "index_regrowls_on_user_id_and_growl_id", :unique => true

  create_table "twitter_accounts", :force => true do |t|
    t.integer  "authentication_id"
    t.integer  "uid"
    t.string   "nickname"
    t.string   "last_status_id",    :default => "0", :null => false
    t.string   "image"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "display_name"
    t.string   "authentication_token"
    t.boolean  "private",                :default => false
  end

  add_index "users", ["display_name"], :name => "index_users_on_display_name"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
