Rails.application.routes.draw do
  devise_for :models
  #URLの変更
  # get "/", to: 'articles#index', as: :articles #これだとうまくDBが構築できない
  # post "/" => 'article#create'
  root to: 'articles#index'

  # root to: 'home#index'
  #get "(hostから後ろ)任意のURL", to: 'コントローラのメソッドで行う処理', as: (パスが入った変数？)

  resources :articles #g scaffold --forceで作られた
  resources :sample_articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
