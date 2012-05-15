object @user
attributes :id, :private

node :name do |user|
  user.display_name
end

node :link do |user|
  api_feed_url(user.display_name.downcase)
end

node(:web_url) do |user|
  root_url(subdomain: user.display_name.downcase)
end

node(:items) do |user|
  pages   = user.posts.pages
  results = {}

  results[:pages]       = pages
  results[:first_page]  = api_items_url(user_display_name: user.display_name.downcase, page: 1)
  results[:last_page]   = api_items_url(user_display_name: user.display_name.downcase, page: pages)
  results[:most_recent] =
    user.posts.page(1).map do |post|
      partial("api/items/show", object: post)
    end

  results
end
