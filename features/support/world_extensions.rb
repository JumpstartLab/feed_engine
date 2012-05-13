module WorldExtensions
  def flash_text
    find("#flash").text
  end

  def selector_for(scope)
    case scope
    when /the text post form/
      "form[name=text-message]"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end

  def set_host(sub)
    Capybara.default_host = "#{sub}.example.com" #for Rack::Test
    Capybara.app_host = "http://#{sub}.127localhost.com:6543"
  end
end

When /^(.*) within ([^:"]+)$/ do |step, scope|
  within(selector_for(scope)) do
    self.step step
  end
end

World(WorldExtensions)
