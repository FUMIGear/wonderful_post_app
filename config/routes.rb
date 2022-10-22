Rails.application.routes.draw do
  #URLの変更
  get "/", to: 'articles#index', as: :articles
  post "/" => "articles#index"
  # post "/" to: "articles#index"
  # get "/", to: 'articles#create', as: :articles
  #get "(hostから後ろ)任意のURL", to: 'コントローラのメソッドで行う処理', as: (パスが入った変数？)
  # root to: 'articles#index' #模範回答
  # root 'articles#index' #模範回答(to:は省略できる)
  #rootは「https://localhost:3000」で表示するページを指定する（←左記固定）
  #getはURLを指定して、表示するページを指定する（URLが自由）


  resources :articles #g scaffold --forceで作られた
  # root to: 'article#index'
  resources :sample_articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
