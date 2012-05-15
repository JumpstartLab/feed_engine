module ApiHelper
  include Rack::Test::Methods
  def app
    Rails.application
  end
end

Rspec.configure do |c|
  c.include ApiHelper, :type => :api
end
