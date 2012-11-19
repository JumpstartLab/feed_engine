class CreateTableTopics < ActiveRecord::Migration
  create_table "topics", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["name"], :name => "index_topics_on_name"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

end
