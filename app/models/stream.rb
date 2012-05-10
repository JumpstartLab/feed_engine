class Stream < ActiveRecord::Base
  belongs_to :user
  belongs_to :stream_item, :polymorhpic => true
end
