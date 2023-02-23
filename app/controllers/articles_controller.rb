class ArticlesController < ApplicationController
	skip_before_action :authenticate_user!, only: %i[index show]
  # before_action :set_article, only: %i[show edit update destroy ] #Task11-1まで
  before_action :set_article, only: %i[ edit update destroy ] #Task11-2で変更

  # before_actionは何かを実行する前に行う処理
  # 下記にset_articleメソッドがある
  # onlyは処理を指定する。（skipなら「次のシンボルは無視する」ということ）
  # %iはシンボル形式に変換する。だからonly:[:show,:edit,:update,:destroy]と書いてもok
  # Task11-2:なぜbefore_actionからshowを消した？→記事を見るだけなら誰でもええやん

  #Task10で追加したコード
  # before_action :authenticate_user! #これいる？ヘルパー使う場合に使うbeforeaction→必要やった→やっぱ必要なかった→特定の条件下で必要やったw
  # before_action :authenticate_member! #これいる？ヘルパー使う場合に使うbeforeactionな気がする→必要やった。なくてもいけた
  #上がないとトップ画面でログイン画面が出てこない
  #authenticate_memberがないとDBにユーザを登録できない。上のメソッドがない？
  # でもなくても行けた。よくわからないwwww
  # 結論：authenticate_user!はログイン画面に移行するメソッド／アカウントの登録とは別。なくても動くが挙動は大きく変わるはず

  # GET /articles or /articles.json
  def index
    # @articles = Article.all #Task12まで使っていた。
    # @articles = Article.all.page(params[:page]) # Task13まで
    # search = Article.where('title LIKE ?', "%#{title}%") #あいまい検索
    # Task14で追加／タイトルのあいまい検索
    article = Article.all #articlesに全記事を代入する
    title = params[:title] #text_tagで取得したパラメータ
    # binding.pry
    article = artcile.where("title LIKE ?", "%#{title}%") if title.present? #if修飾子（Tの場合は処理 if 条件式）
    @articles = article.all.page(params[:page]) #ページネイションで表示する。
    # Article：DBテーブル、.all：全部。つまり、Articleテーブルのデータを全て@articleに入れる。
    # @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page]) #参考サイトのコード
    # 上記２行を合体してみた
    # @articles = Article.all.includes(:user).order(created_at: :desc).page(params[:page])
    # title=nilの場合、全部の記事を取得する。また検索ワードを入れなかったらprams[:title]はnilを返す
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id]) #追加
    # Task11-2で追加になっているが、before_actionに組まないのはなぜか？
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
    # @article = Article.new(article_params) #Task11-1まで
    # @article.user_id = current_user.id #自分で変更したコード
    @article = current_user.articles.new(article_params) # Task11-2で追加（模範）

    # respond_to do |format| #これなに？→レスポンスをフォーマットごとに変えてる。（HTML形式とJSON形式）
      if @article.save #記事が保存できるか
        # 真の場合の処理
        redirect_to @article, notice: "#{t('activerecord.models.article')}を作成しました。" #Task11-2で模範回答に調整
        # format.html { redirect_to article_url(@article), notice: "記事の作成に成功しました！" }
        # format.json { render :show, status: :created, location: @article }
      else
        render :new, status: :unprocessable_entity #模範回答
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    # end
    # def create #なぜこれを作ったのか覚えてない
    #   @article = Article.new(p
    #     title: params[:title],
    #     content: params[:content]
    #   )
    #   @article.save!
    #   render :show
    # end
  end

  def update
    # binding.pry
    if  @article.user_id == current_user.id #アカウントが違った場合の処理
      # respond_to do |format|
        if @article.update(article_params)
          redirect_to article_url(@article), notice: "記事を更新しました。"
          # format.html { redirect_to article_url(@article), notice: "記事を更新しました。" }
          # format.json { render :show, status: :ok, location: @article } #jsonは使わない
          # redirect_to @article, notice: "Article was successfully updated." #模範回答
          # notice:"記事を更新しました"とサイト上に表示される機能
          # fromat.html{}はhtml形式に変更する。（.htmlを.jsonにするとjson形式になる）
        else
          render :edit, status: :unprocessable_entity
          # format.html { render :edit, status: :unprocessable_entity }
          # format.json { render json: @article.errors, status: :unprocessable_entity } #jsonは使わない
          # render :edit, status: :unprocessable_entity #模範回答
        end
      # end
    else
      redirect_to article_url(@article), notice: "アカウントが違います！"
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    if  @article.user_id == current_user.id
      @article.destroy #destroyメソッドを実行する
      respond_to do |format|
        # redirect_to articles_url, notice: "Article was successfully destroyed."
        # format.html { redirect_to articles_url, notice: "記事を削除しました。" } #articles_urlはarticle#indexを開く。多分format.htmlはなくてもいける。
        format.html { redirect_to  mypage_index_url, notice: "記事を削除しました。" } #削除後にmypage_index戻るように設定
        # format.json { head :no_content } #jsonは使わないから
      end
    else
      redirect_to articles_url, notice: "垢ちゃう"
    end
  end

  # Task14で追加（検索フォームに関するメソッド／いらない）
  def search
    title = params[:title]
    # binding.pry
    # タイトルの完全一致で検索
    # @article=Article.where(title:title)
    # タイトルのあいまい検索
    @article=Article.where('title LIKE ?', "%#{title}%")
    # @article=Article.where('title LIKE ?', "%#{params[:title]}%")
    # 検索結果で見つからなかった場合の処理。
    # if Article.where(title:title).empty?
    #   puts "真"
    #   # @article = Article.all.page(params[:page])
    # else
    #   puts "偽"
    #   @article = Article.where(title:title)
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = current_user.articles.find(params[:id]) #Task11-2で追加、模範回答
      # @article = Article.find(params[:id]) #Task11-1まで
      # before_actionの後ろにset_articleがあり、ここでその処理を行ってる。
      # "Article.find(id)"でArticlesテーブルの指定したidのレコードを引っ張る
      # .findは検索メソッド
      # DBとデータをやり取りする際にparamsメソッドを使う？
      # findメソッドを使わないとエラーになるのかな？
      # params[:id]でエラーになったら、.find(params[:id])で試してみる→id参照するならfindメソッドは必要
    end

    # Only allow a list of trusted parameters through.
    # このメソッド使ってるかわからない（笑）
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
