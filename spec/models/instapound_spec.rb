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

require 'spec_helper'

describe Instapound do
  pending "add some examples to (or delete) #{__FILE__}"
end
