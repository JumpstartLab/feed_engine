task :gource do
  # Scrape avatars
  require 'digest/md5'
  require 'net/http'

  avatar_folder = ".git/avatar"
  mkdir_p(avatar_folder)

  names  = `git log --pretty=format:"%an"`.split("\n")
  emails = `git log --pretty=format:"%ae"`.split("\n")
  authors = names.zip(emails).uniq.each do |name, email|
    author_file = File.join(avatar_folder, "#{name}.png")
    next if File.exist?(author_file)

    image_path = "/avatar/#{Digest::MD5.hexdigest(email.downcase)}?d=404&size=90"

    Net::HTTP.start("www.gravatar.com") do |http|
      resp = http.get(image_path)
      if resp.code.to_i == 200
        open(author_file, "wb") do |file|
          file.write(resp.body)
        end
      end
    end
  end

  # Show gource
  sh "gource --load-config .gource --user-image-dir .git/avatar/"
end
