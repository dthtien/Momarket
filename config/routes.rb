Rails.application.routes.draw do
resources :posts
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root  'posts#index'

get 'auth/:provider/callback', to: 'sessions#create'
delete 'sessions/destroy', as: :logout

resources :posts
resources :products, only: [:new]

end