class Article < ApplicationRecord
  # 参考サイトより追記
  belongs_to:user

  validates :title, presence: true #uniqueness: true # Task12ではバリデーションの設定はしない。
  validates :content, presence: true
  # まだテストしてない（エラーが起きたら、コメント外して）
  # def user
  #   return User.find_by(id: self.user_id)
  # end
end
