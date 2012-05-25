class TopicsController < ApplicationController
  def index
    @topics = Topic.trending_topics
  end
end
