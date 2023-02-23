class MypageController < ApplicationController
  def show
    # binding.pry
    # @articles = current_user.articles  # Task12まで使ってた
    # @articles = current_user.articles.page(params[:page]) # Task13で追加した（ページネイションで表示する）
    # Task14で追加したコード
    article = current_user.articles
    title = params[:title] #text_tagで取得したパラメータ
    article = article.where('title LIKE ?', "%#{title}%") if title.present? #あいまい検索
    @articles = article.page(params[:page]) #ページネイションで表示する。
  end
end
