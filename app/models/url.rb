class Url < ApplicationRecord

  validates :url, :token, :access_count, presence: true
  validates :token, uniqueness: true
  validate :validate_url

  private

  def validate_url
    return if valid_url?(url)

    errors.add(:url, :invalid)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

end
