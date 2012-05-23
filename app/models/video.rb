class Video < Growl

  include VideoValidations

  def icon
    "glyphicons/glyphicons_008_film.png"
  end

  def youtube_urlify
    youtu = /http:\/\/youtu.be\//
    youtube = /(?<=[?&]v=)[^&$]+/

    if self.link.scan(youtu).present?
      self.link.gsub(youtu,"")
    else
      self.link.scan(youtube)
    end
  end

end
