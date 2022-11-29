class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable #自動生成

  # devise :database_authenticatable, :registerable, :confirmable, :recoverable, stretches: 13←これは？
end
