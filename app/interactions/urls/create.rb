module Urls
  class Create < ApplicationInteraction

    string(:url)

    def execute
      token = GenerateToken.run!
      new_url = Url.new(url: url, token: token)

      return new_url if new_url.save

      errors.merge!(new_url.errors)
    end

    def to_model
      Url.new
    end

  end
end
