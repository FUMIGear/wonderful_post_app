class Article < ApplicationRecord
  # 参考サイトより追記
  belongs_to:user

  # まだテストしてない（エラーが起きたら、コメント外して）
  # def user
  #   return User.find_by(id: self.user_id)
  # end
end
