module Urls
  class GenerateToken < ApplicationInteraction

    MAX_ATTEMPTS = 5
    TOKEN_SIZE = 10

    def execute
      MAX_ATTEMPTS.times do
        token = generate_token
        return token unless Url.exists?(token: token)
      end
      raise('max token attempts exceeded')
    end

    private

    def generate_token
      SecureRandom.base58(TOKEN_SIZE)
    end

  end
end
