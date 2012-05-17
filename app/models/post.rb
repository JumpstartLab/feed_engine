# == Schema Information
#
# Table name: posts
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  postable_id   :integer
#  postable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  points        :integer         default(0)
#  refeed_id     :integer
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, :polymorphic => true, dependent: :destroy
  attr_accessible :points

  def as_json(*params)
    post = self.postable
    if post.class == ImagePost
      {:photo => post.image.big, :description => post.description,
        :created_at => post.created_at}
    elsif post.class == LinkPost
      {:link => post.url, :description => post.description,
        :created_at => post.created_at}
    elsif post.class == TextPost
      {title: post.title, :body => post.body, :created_at => post.created_at}
    end
  end

  def add_point
    self.points += 1
  end

end
