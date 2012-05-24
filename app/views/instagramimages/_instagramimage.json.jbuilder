json.(instagramimage, :id, :content, :post_time, :handle, :caption)
json.type "instagramimage"
json.post_time time_ago_in_words(instagramimage.post_time)
json.handle instagramimage.handle