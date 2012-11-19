class Tweet < Growl

  def comment_with_link
    add_links.add_username_link
    self.comment
  end

  def add_links
    links = self.comment.scan(LINK_GSUB)
    links.each do |link|
      real_link = "<a href='#{link}'>#{link}</a>"
      self.comment = comment.gsub("#{link}", real_link)
    end
    self
  end

  def add_username_link
    usernames = self.comment.scan(/@(\w+)/)
    usernames.each do |username|
      link = "<a href='http://twitter.com/#{username.first}'>"+
             "@#{username.first}</a>"
      self.comment = comment.gsub("@#{username.first}", link)
    end
    self
  end

  def icon
    "glyphicons/glyphicons_392_twitter.png"
  end
end
# == Schema Information
#
# Table name: growls
#
#  id                  :integer         not null, primary key
#  type                :string(255)
#  comment             :text
#  link                :text
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  user_id             :integer
#  photo_file_name     :string(255)
#  photo_content_type  :string(255)
#  photo_file_size     :integer
#  photo_updated_at    :datetime
#  regrowled_from_id   :integer
#  original_created_at :datetime
#  event_type          :string(255)
#

