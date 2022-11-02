class Model < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :recoverable, stretches: 13 #ここまで書かないのか？
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # user_signed_in?
end
