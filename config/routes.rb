Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'most_mentions', to: 'tweets#most_mentions'
  get 'most_relevants', to: 'tweets#most_relevants'
end
