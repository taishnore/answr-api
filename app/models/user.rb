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

# what does "has_secure_password" mean? where does it come from?
# the model file seems essentially to handle the relationships.
# where are the data types and DB info figured out? -- the DB files. how to initalize db?
#