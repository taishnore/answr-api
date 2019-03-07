class User < ApplicationRecord
  has_secure_password

  has_many :memes, dependent: :destroy
  has_many :user_games
  has_many :games, through: :user_games

  has_many :answers
  has_many :rounds, through: :answers

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

end
