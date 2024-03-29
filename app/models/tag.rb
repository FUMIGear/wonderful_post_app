class Tag < ApplicationRecord
  validates :name, presence: true #presence trueにすれば必須項目

  # 記事と中間テーブルの紐付け
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags
  # accepts_nested_attributes_for :article_tag, allow_destroy: true #模範回答ではいらないらしい。
end
