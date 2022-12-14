class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :user_id, :integer
    # カラムの追加 articlesテーブルにuser_id（integer型）を追加

    # 模範回答
    # add_reference :articles, :user, foreign_key: true
  end
end
