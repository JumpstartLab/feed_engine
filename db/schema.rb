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

ActiveRecord::Schema.define(:version => 20120516192740) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "handle"
  end

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "link"
    t.boolean  "private",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "githubevents", :force => true do |t|
    t.string   "handle"
    t.string   "repo"
    t.string   "event_id"
    t.string   "action"
    t.datetime "event_time"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.text     "content"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "url"
    t.string   "picture"
    t.text     "remote_picture_url"
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "links", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "comment"
  end

  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "texts", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "texts", ["user_id"], :name => "index_texts_on_user_id"

  create_table "tweets", :force => true do |t|
    t.text     "content"
    t.text     "source_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "handle"
    t.datetime "tweet_time"
  end

  create_table "users", :force => true do |t|
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "display_name",     :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "subdomain"
    t.string   "api_key"
    t.string   "authentication_token"
  end

end
