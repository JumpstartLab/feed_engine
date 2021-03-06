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

ActiveRecord::Schema.define(:version => 20120523211031) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "login"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "secret"
  end

  add_index "authentications", ["id"], :name => "index_authentications_on_id"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "awards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "awardable_id"
    t.string   "awardable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "status",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "friendships", ["friend_id", "user_id"], :name => "index_friendships_on_friend_id_and_user_id"
  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["id"], :name => "index_friendships_on_id"
  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "github_feed_items", :force => true do |t|
    t.string   "content"
    t.datetime "posted_at"
    t.integer  "user_id"
    t.string   "event_type"
    t.integer  "github_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "screen_name"
    t.string   "repo"
  end

  create_table "instagram_feed_items", :force => true do |t|
    t.string   "image_url"
    t.datetime "posted_at"
    t.integer  "user_id"
    t.string   "instagram_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "comment"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.string   "type"
    t.text     "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "file"
    t.integer  "original_post_id"
  end

  add_index "posts", ["id"], :name => "index_posts_on_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "twitter_feed_items", :force => true do |t|
    t.text     "content"
    t.datetime "posted_at"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "tweet_id"
    t.string   "screen_name"
  end

  add_index "twitter_feed_items", ["id"], :name => "index_twitter_feed_items_on_id"
  add_index "twitter_feed_items", ["user_id"], :name => "index_twitter_feed_items_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "display_name",           :default => "",    :null => false
    t.boolean  "private",                :default => false
    t.string   "background"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "twitter_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
