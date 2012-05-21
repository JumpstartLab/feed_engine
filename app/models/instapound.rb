# == Schema Information
#
# Table name: instapounds
#
#  id              :integer         not null, primary key
#  image_url       :string(255)
#  poster_id       :integer
#  body            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  subscription_id :integer
#  points          :integer         default(0)
#

# Events on Instagram that a user does
class Instapound < ActiveRecord::Base
  include Postable
  include Service

  attr_accessible :image_url, :body
end
