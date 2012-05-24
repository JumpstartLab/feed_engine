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

ActiveRecord::Schema.define(:version => 20120523221328) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
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

  create_table "github_events", :force => true do |t|
    t.string   "event_type"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "subscription_id"
    t.string   "repo"
    t.integer  "poster_id"
    t.integer  "points",          :default => 0
  end

  create_table "images", :force => true do |t|
    t.text     "description"
    t.text     "url"
    t.integer  "poster_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "points",      :default => 0
  end

  add_index "images", ["poster_id"], :name => "index_images_on_poster_id"

  create_table "instapounds", :force => true do |t|
    t.string   "image_url"
    t.integer  "poster_id"
    t.string   "body"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "subscription_id"
    t.integer  "points",          :default => 0
  end

  create_table "items", :force => true do |t|
    t.integer  "poster_id"
    t.integer  "post_id"
    t.string   "post_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "refeed"
    t.integer  "original_poster_id"
  end

  create_table "links", :force => true do |t|
    t.text     "description"
    t.text     "url"
    t.integer  "poster_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "points",      :default => 0
  end

  add_index "links", ["poster_id"], :name => "index_links_on_poster_id"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.integer  "poster_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "points",     :default => 0
  end

  create_table "point_gifts", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "user_name"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "body"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "poster_id"
    t.integer  "points",          :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "display_name"
    t.string   "api_key"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
