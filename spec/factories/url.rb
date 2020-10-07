FactoryBot.define do
  factory :url do
    sequence(:url) { |n| "https://example.com/test#{n}" }
    sequence(:token) { |n| "abc#{n}" }
    access_count { 0 }
  end
end
