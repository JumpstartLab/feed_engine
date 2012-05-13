task :slimify do
  # ERB to HAML
  erb_files = Dir.glob("**/*.html.erb")
  erb_files.each do |path|
    new_path = path.gsub(/erb$/, "haml")
    sh "html2haml -r #{path} #{new_path}"
  end

  # HAML to SLIM
  haml_files = Dir.glob("**/*.html.haml")
  haml_files.each do |path|
    new_path = path.gsub(/haml$/, "slim")
    sh "haml2slim #{path} #{new_path}"
  end
end
