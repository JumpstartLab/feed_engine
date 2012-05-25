class Topic < ActiveRecord::Base
  attr_accessible :name, :user, :user_id
  belongs_to :user

  scope :by_date, order("original_created_at DESC")

  TEN_MINUTES = BigDecimal.new(600)
  HALF_HOUR   = BigDecimal.new(1800)
  ONE_HOUR    = BigDecimal.new(3600)

  def self.trending_topics
    trending_topics = { }
    collect_topic_speeds.each do |topic|
      puts topic.inspect
      trending_topics[ topic[:name] ] =
        topic[:acceleration] * 4 + topic[:velocity] * 2 + topic[:count]
    end
    trending_topics.sort{ |a, b| b[1]<=>a[1] }
  end

  def self.hot_topics
    Topic.count(group: "name", order: 'count(*) DESC', limit: 100)
  end

  def self.collect_topic_speeds
    hot_topics.collect do |name, number_of_growls|
      { name: name, count: number_of_growls,
        velocity: velocity(name, Time.now),
        acceleration: acceleration(name, Time.now) }
    end
  end

  def self.count_growls(name, time_start, time_end)
    Topic.where(name: name).where{ (created_at.gt my{ time_start }) &
                                   (created_at.lt my{ time_end }) }.count  
  end

  def self.velocity(name, time)
    growls_per_hour = count_growls(name, time - ONE_HOUR, time)
    [0, growls_per_hour].max
  end

  def self.acceleration(name, time)
    starting_vel       = BigDecimal.new(velocity(name, time - TEN_MINUTES))
    ending_vel         = BigDecimal.new(velocity(name, time))
    growls_per_hour_squared = (ending_vel - starting_vel) / (TEN_MINUTES / ONE_HOUR)
    [0, growls_per_hour_squared].max
  end
end
