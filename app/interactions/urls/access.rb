module Urls
  class Access < ApplicationInteraction

    string(:token)

    def execute
      url = Url.find_by(token: token)

      unless url
        errors.add(:token, :invalid)
        return
      end

      Url.increment_counter(:access_count, url.id)
      url
    end

  end
end
