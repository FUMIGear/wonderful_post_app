Rails.application.routes.draw do
  #URLの変更
  get '/mypage', to: 'mypage#index'
    #Task11-3で追加。URLの末尾＝mypage#showだよ。今回はindex.htmlで作ったので模範と少し違う
  # get "/", to: 'articles#index', as: :articles #これだとうまくDBが構築できない
  # post "/" => 'article#create'
  root to: 'articles#index'
  # root to: 'mypage#index'
  # root to: 'home#index' #Task10-1で追加したコード
  #get "(hostから後ろ)任意のURL", to: 'コントローラのメソッドで行う処理', as: (パスが入った変数？)

  devise_for :users
  # devise_for :models #いらないかなー

  resources :articles #g scaffold --forceで作られた
  resources :sample_articles
  resources :mypage #Task11-3で手動で追記した
  # resources :test_tags #RESTfulな動作にするには必要。
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
