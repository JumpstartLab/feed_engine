require 'addressable/uri'

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    begin
      uri = Addressable::URI.parse(value)

      unless ["http","https"].include?(uri.scheme)
        raise Addressable::URI::InvalidURIError
      end
    rescue Addressable::URI::InvalidURIError
      record.errors.add(attribute, :url, options.merge(:value => value))
    end
  end
end
