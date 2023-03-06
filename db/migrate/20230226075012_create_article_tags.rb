class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      # t.references :article #元々はこの状態
      # t.reference :tag #元々はこの状態
      t.references  :article,  foreign_key: true #, index: true # index:trueにするとインデックスが作成される
      t.references  :tag, foreign_key: true #, index: true # foreign_key:trueは外部キーのみ受け付ける。
      # 模範回答ではindex:trueは書かれてない。

      t.timestamps
    end
  end
end
