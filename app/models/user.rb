class User < ApplicationRecord

  has_many :memes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

end
