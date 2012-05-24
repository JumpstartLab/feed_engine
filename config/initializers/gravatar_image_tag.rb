GravatarImageTag.configure do |config|
  config.default_image = ['http://1337807.com/images/fire_flower.jpg']
  config.filetype      = nil   # Set this if you require a specific image file format 
  config.rating        = nil   # Set this if you change the rating of the images that will be returned 
  config.size          = nil   # Set this to globally set the size of the gravatar image returned 
  config.secure        = false # Set this to true if you require secure images on your pages.
end
