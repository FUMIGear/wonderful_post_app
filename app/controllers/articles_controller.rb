class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  # before_actionは何かを実行する前に行う処理
  # 下記にset_articleメソッドがある
  # onlyは処理を指定する。
  # %iはシンボル形式に変換する。だからonly:[:show,:edit,:update,:destroy]と書いてもok

  #Task10で追加したコード
  # before_action :authenticate_user! #これいる？ヘルパー使う場合に使うbeforeaction→必要やった→やっぱ必要なかった
  # before_action :authenticate_member! #これいる？ヘルパー使う場合に使うbeforeactionな気がする→必要やった。なくてもいけた
  #上がないとトップ画面でログイン画面が出てこない
  #authenticate_memberがないとDBにユーザを登録できない。上のメソッドがない？
  # でもなくても行けた。よくわからないwwww

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    #Article：データベース、.all：全部。データベース内のデータを全て@articleに入れる。
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "記事の作成に成功しました！" }
        # format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    # def create
    #   @article = Article.new(p
    #     title: params[:title],
    #     content: params[:content]
    #   )
    #   @article.save!
    #   render :show
    # end
  end

  # PATCH/PUT /articles/1 or /articles/1.json

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "記事を更新しました。" }
        # format.json { render :show, status: :ok, location: @article } #jsonは使わない
        # redirect_to @article, notice: "Article was successfully updated." #模範回答
        # notice:"記事を更新しました"とサイト上に表示される機能
        # fromat.html{}はhtml形式に変更する。（.htmlを.jsonにするとjson形式になる）
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @article.errors, status: :unprocessable_entity } #jsonは使わない
        # render :edit, status: :unprocessable_entity #模範回答
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy #destroyメソッドを実行する
    respond_to do |format|
      # redirect_to articles_url, notice: "Article was successfully destroyed."
      format.html { redirect_to articles_url, notice: "記事を削除しました。" } #articles_urlはarticle#indexを開く。多分format.htmlはなくてもいける。
      # format.json { head :no_content } #jsonは使わないから
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      # before_actionの後ろにset_articleがあり、ここでその処理を行ってる。
      # "Article.数値"でArticlesテーブルのレコードを引っ張れる。
      # .findは検索メソッド
      # DBとデータをやり取りする際にparamsメソッドを使う？
      # findメソッドを使わないとエラーになるのかな？
      # params[:id]でエラーになったら、.find(params[:id])で試してみる
    end

    # Only allow a list of trusted parameters through.
    # このメソッド使ってるかわからない（笑）
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
