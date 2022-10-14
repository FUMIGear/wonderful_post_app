class Article < ApplicationRecord
  # validates :account, presence: true, uniqueness: { case_sensitive: false } #講義ではコレ
  validates :title, presence :true
  validates :content, presence :true
end
