

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id, :last_post_id
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates_presence_of :follower_id, :followed_id

  def self.relationship_summary
    ActiveRecord::Base.connection.select_all(<<-SQL)
      select follower.display_name         as follower,
             followed.display_name         as followed,
             follower.authentication_token as follower_token,
             max(refeed_post.refeed_id)    as last_id
      from users as follower
      cross join users as followed
      inner join relationships on follower.id = relationships.follower_id
                              and followed.id = relationships.followed_id
      inner join posts as original_post on original_post.user_id = followed.id
      left join posts as refeed_post on original_post.id = refeed_post.refeed_id
      group by follower, followed, follower_token
    SQL
  end
end
