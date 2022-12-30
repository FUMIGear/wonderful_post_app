class MypageController < ApplicationController
  def index
    @articles = current_user.articles
  end
end
