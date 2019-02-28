class User < ApplicationRecord
  has_secure_password

  has_many :memes, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true



end
