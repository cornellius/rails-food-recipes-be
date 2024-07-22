Rails.application.routes.draw do
  constraints(lambda { |req| req.format == :json }) do
    resources :categories, only: [:index, :show]
    resources :authors, only: [:index, :show]
    resources :recipes, only: [:index, :show]
  end

  root to: "pages#home"

  get "/up/", to: "up#index", as: :up
  get "/up/databases", to: "up#databases", as: :up_databases

  # Sidekiq has a web dashboard which you can enable below. It's turned off by
  # default because you very likely wouldn't want this to be available to
  # everyone in production.
  #
  # Uncomment the 2 lines below to enable the dashboard WITHOUT authentication,
  # but be careful because even anonymous web visitors will be able to see it!
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

end
