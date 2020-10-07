class Url < ApplicationRecord

  validates :url, :token, :access_count, presence: true
  validates :url, length: { maximum: 2048 }
  validates :token, uniqueness: true
  validate :validate_url_format

  private

  def validate_url_format
    return if valid_url_format?(url)

    errors.add(:url, :invalid)
  end

  def valid_url_format?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

end
