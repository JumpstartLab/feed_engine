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

ActiveRecord::Schema.define(:version => 20120523232108) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "login"
  end

  create_table "github_items", :force => true do |t|
    t.text     "event"
    t.integer  "user_id"
    t.integer  "points_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "event_id"
  end

  create_table "image_items", :force => true do |t|
    t.text     "url"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "points_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "instagram_items", :force => true do |t|
    t.text     "image"
    t.string   "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "link_items", :force => true do |t|
    t.text     "url"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "points_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pointable_id"
    t.string   "pointable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "stream_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "streamable_id"
    t.string   "streamable_type"
    t.integer  "points_count",       :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "refeed",             :default => true
    t.integer  "retrouted_from_id"
    t.integer  "original_author_id"
  end

  add_index "stream_items", ["streamable_type", "streamable_id"], :name => "index_stream_items_on_streamable_type_and_streamable_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "text_items", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "points_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "twitter_items", :force => true do |t|
    t.text     "tweet"
    t.integer  "user_id"
    t.integer  "points_count", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.datetime "tweet_time"
    t.string   "status_id"
  end

  add_index "twitter_items", ["user_id"], :name => "index_twitter_items_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "display_name",           :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
