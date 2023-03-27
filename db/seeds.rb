# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 一つのアカウントを作る場合
# User.create!(
# 	email: 'seeddefault@test.com',
# 	password: 'password'
# )
# Task12:2-1
# 自分の回答。模範回答を解読するため、コメントアウトした。
# 3.times do |n|
# 	User.create!(
# 		# email: "user00#{n}@test.com", # nは0番目からスタート。最初に１を入れる場合、n+1にする。
# 		email: "user00#{n+1}@test.com", # n+1にすると[1,2,3]になる。
# 		password: "test1234"
# 	)
#   5.times do |a| # 数が多すぎて処理が大変なので、テストでは5個にする。（本当は50記事）
#     Article.create!(
#       title: "No.#{a+1}:user00#{n+1}の記事",
#       content: "Content No.#{a+1}:user00#{n+1}の記事の本文",
#       user_id:n+1
#     )
#   end
# end

# タグの設定（重複しないようになってる！）
tags = %w(楽しい お金 つぶやき 屋外 旅行)
tags.each { |tag| Tag.find_or_create_by!(name: tag) } #模範

# 模範回答
# アカウント数３つ
3.times do |i|
  i += 1 #通常[0..2]のところを[1..3]にする
  # .find_or_create_by!: 条件を指定して初めの1件を取得し1件もなければ作成
  user = User.find_or_create_by!(email: "user00#{i}@test.com") do |_user|
    # binding.pry
    _user.password = 'test1234'
    # _user.password = '1234test' #すでに存在する場合はスルーされる
  end
  # _userはUserのこと。
  # emailを作成した場合、User.passwordは'test1234'にするという処理。
  # find_or_created_byで指定したカラムに特定のレコードがあるかないか判断する。
  # ない→そのデータでレコードを作り、付随するカラムを追記する。

  #１つのアカウントに作成する記事は６つ
  8.times do |ii| #本来のループ回数は50（50記事）
    ii += 1
    user.articles.find_or_create_by!(title: "No.#{ii}: user00#{i}の記事") do |article|
      # binding.pry
      article.content = "No.#{ii}: user00#{i}の記事の本文"
      # binding.pry
      # article.tag_ids = Tag.all.pluck(:id) #模範回答
      article.tag_ids = Tag.pluck(:id) #これでもいけるんじゃない？

      # Task15-2：seedファイルの編集
      # tag = article.tag_ids.push(t)
      # article.tag_ids=ii
      # article.tags.find(i) #→失敗
      # article.tags = "楽しい" #→失敗
    end

    # １つの記事に付くタグは４つ
    # ti += 1 #記事数をカウント
    # binding.pry
    # 4.times do |t|
    #   t +=1
      #成功。このメソッドは複数のレコードも参照できる
      # ArticleTag.find_or_create_by(article_id:ti, tag_id:t)

      # 最初に作ったやつ（seedを読み込むと重複する）
      # ArticleTag.create(
      #   # binding.pry
      #   article_id:ti
      #   tag_id:t
      # )

      # 失敗作（article_id:tiは4timesが終わらないとカウントが変わらないため、最初のタグが付くだけになる）
      # ArticleTag.find_or_create_by(article_id:ti) do |at|
      #   # binding.pry
      #   at.tag_id=t
      # end
    # end
      # article.tag_ids = tag
  end
end
# タグつける処理。
# 6.times do |a|
#   a += 1
# end
# |artile|はuser.articlesになる。

# title:があれば→作らない。なければ→作って、contentはNo.*****にするという処理
# user.articlesの記事の中に特定のレコードがあるかないか判断する。
# 参照したデータがない→そのレコードを作成し、付随するデータを追記する。
# 同じ記事があってもエラーやfalseを返さない。あるんだね〜でスルーされる。
# メソッドの末尾に!の有無がある→エラーやfalseの条件って何？
