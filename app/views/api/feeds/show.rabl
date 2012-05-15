object @user
attributes :id, :private

node :name do |user|
  user.display_name
end

node :link do |user|
  api_feed_url(user.display_name.downcase)
end

child :posts => :items do
  extends "api/items/show"
end

#node :items do |user|
  #user.posts.map do |post|
    #if post.postable.kind_of?(ImagePost)
      #partial("api/items/image", object: post)
    #else
      #partial("api/items/image", object: post)
    #end
  #end
#end

#child :

#{
  #"name": "hungryfeeder",
  #"id": 4,
  #"private": false,
  #"link": "http://api.feedengine.com/feeds/hungryfeeder",
  #"items": {
    #"pages": 10,
    #"first_page": "http://api.feedengine.com/feeds/hungryfeeder/items?page=1",
    #"last_page": "http://api.feedengine.com/feeds/hungryfeeder/items?page=10",
    #"most_recent": [
      #{
        #"type": "TextItem",
        #"text": "I had some really good Chinese food for lunch today.",
        #"created_at": "2011-09-06T17:26:27Z",
        #"id": 100,
        #"feed": "http://api.feedengine.com/feeds/hungryfeeder",
        #"link": "http://api.feedengine.com/feeds/hungryfeeder/items/100",
        #"refeed": false,
        #"refeed_link": ""
      #},
      #{
        #"type": "ImageItem",
        #"image_url": "http://cdn.fd.uproxx.com/wp-content/uploads/2012/05/Thorgi-597x800.jpg",
        #"comment": "Check out this Thorgi.",
        #"created_at": "2011-09-05T17:28:27Z",
        #"id": 99,
        #"feed": "http://api.feedengine.com/feeds/hungryfeeder",
        #"link": "http://api.feedengine.com/feeds/hungryfeeder/items/99",
        #"refeed": true,
        #"refeed_link": "http://api.feedengine.com/feeds/mattyoho/items/123"
      #},
      #{
        #"type": "LinkItem",
        #"link_url": "http://blog.mitchcrowe.com/blog/2012/04/14/10-most-underused-activerecord-relation-methods/",
        #"comment": "These are useful ActiveRelation methods.",
        #"created_at": "2011-09-04T17:30:27Z",
        #"id": 98,
        #"feed": "http://api.feedengine.com/feeds/hungryfeeder",
        #"link": "http://api.feedengine.com/feeds/hungryfeeder/items/98",
        #"refeed": false,
        #"refeed_link": ""
      #}
    #]
  #},
  #"web_url": "http://hungryfeeder.feedengine.com/"
#}
