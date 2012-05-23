class InstagramAccount < ActiveRecord::Base
  attr_accessible :datetime, :image, :last_status_id, :nickname, :uid
  belongs_to :authentication

  delegate :user, :to => :authentication
  delegate :id, :to => :user, :prefix => true

  def update_last_status_id_if_necessary(new_status_id)
    if DateTime.parse(last_status_id).to_i < DateTime.parse(new_status_id).to_i
      update_attribute("last_status_id", new_status_id)
    end
  end

end
