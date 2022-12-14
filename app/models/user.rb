class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable #自動生成

  # ユーザと投稿の紐付け（参考サイトから）
  # has_many :posts, dependent: :destroy, foreign_key: :post_user_id
   # サイトはpostsだが、このアプリは記事（articles）でかつ外部キーのカラムはuser_idなので
  # has_many :articles, dependent: :destroy, foreign_key: :user_id
  has_many :articles #こっちでもうまく連携できてる。

  #模範回答
  # has_many :articles

  # devise :database_authenticatable, :registerabPle, :confirmable, :recoverable, stretches: 13←これは？
end
