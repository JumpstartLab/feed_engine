require 'spec_helper'

describe TwitterAccount do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: twitter_accounts
#
#  id                :integer         primary key
#  authentication_id :integer
#  uid               :integer
#  nickname          :string(255)
#  last_status_id    :string(255)     default("0"), not null
#  image             :string(255)
#  created_at        :timestamp       not null
#  updated_at        :timestamp       not null
#

