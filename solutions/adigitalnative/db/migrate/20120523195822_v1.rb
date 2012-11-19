class V1 < ActiveRecord::Migration
  def change
    create_table "authentications", :force => true do |t|
      t.integer  "user_id"
      t.string   "provider"
      t.string   "token"
      t.string   "secret"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
    add_index "authentications", ["token"], :name => "index_authentications_on_token"
    add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

    create_table "github_accounts", :force => true do |t|
      t.integer  "authentication_id"
      t.integer  "uid"
      t.string   "nickname"
      t.string   "last_status_id",    :default => "0", :null => false
      t.string   "image"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
    end

    add_index "github_accounts", ["authentication_id"], :name => "index_github_accounts_on_authentication_id"
    add_index "github_accounts", ["nickname"], :name => "index_github_accounts_on_nickname"

    create_table "growls", :force => true do |t|
      t.string   "type"
      t.text     "comment"
      t.text     "link"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.integer  "user_id"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "photo_updated_at"
      t.integer  "regrowled_from_id"
      t.datetime "original_created_at"
      t.string   "event_type"
      t.integer  "points",              :default => 0
    end

    add_index "growls", ["regrowled_from_id"], :name => "index_growls_on_regrowled_from_id"
    add_index "growls", ["type"], :name => "index_growls_on_type"
    add_index "growls", ["user_id"], :name => "index_growls_on_user_id"

    create_table "instagram_accounts", :force => true do |t|
      t.string   "uid"
      t.string   "nickname"
      t.string   "image"
      t.string   "last_status_id"
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
      t.integer  "authentication_id"
    end

    add_index "instagram_accounts", ["authentication_id"], :name => "index_instagram_accounts_on_authentication_id"
    add_index "instagram_accounts", ["nickname"], :name => "index_instagram_accounts_on_nickname"
    add_index "instagram_accounts", ["uid"], :name => "index_instagram_accounts_on_uid"

    create_table "meta_data", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.string   "thumbnail_url"
      t.integer  "growl_id"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

    add_index "meta_data", ["growl_id"], :name => "index_meta_data_on_growl_id"

    create_table "subscriptions", :force => true do |t|
      t.integer  "user_id"
      t.integer  "subscriber_id"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
      t.integer  "last_status_id"
    end

    add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"
    add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

    create_table "twitter_accounts", :force => true do |t|
      t.integer  "authentication_id"
      t.integer  "uid"
      t.string   "nickname"
      t.string   "last_status_id",    :default => "0", :null => false
      t.string   "image"
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
    end

    add_index "twitter_accounts", ["authentication_id"], :name => "index_twitter_accounts_on_authentication_id"
    add_index "twitter_accounts", ["nickname"], :name => "index_twitter_accounts_on_nickname"
    add_index "twitter_accounts", ["uid"], :name => "index_twitter_accounts_on_uid"

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

    add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
    add_index "users", ["display_name"], :name => "index_users_on_display_name"
    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end
end
