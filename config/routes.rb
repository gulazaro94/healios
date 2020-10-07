Rails.application.routes.draw do
  root to: 'urls#new'

  resources(:urls, only: [:new, :create, :show])

  get(':token' => 'urls#access', as: :access_url)
end
