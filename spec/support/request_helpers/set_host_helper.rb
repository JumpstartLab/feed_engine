module SetHostHelper
  def set_host(sub)
    Capybara.default_host = "#{sub}.example.com" #for Rack::Test
    Capybara.app_host = "http://#{sub}.127localhost.com:6543"
  end

  def reset_host
    Capybara.default_host = "example.com" #for Rack::Test
    Capybara.app_host = "http://127localhost.com:6543"
  end
end
