class ApplicationDecorator < Draper::Base
  
  def self.per_page
    10
  end
  
end