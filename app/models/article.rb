class Article < ApplicationRecord
  # 参考サイトより追記
  belongs_to:user

  validates :title, presence: true #uniqueness: true # Task12ではバリデーションの設定はしない。
  validates :content, presence: true
  # まだテストしてない（エラーが起きたら、コメント外して）
  # def user
  #   return User.find_by(id: self.user_id)
  # end

  # Task15で追加（タグと記事の関係）
	has_many :article_tags, dependent: :destroy #article_tagとの関係も記述する
  has_many :tags, through: :article_tags #article_tag(中間)を通して、tagと紐付け

end
