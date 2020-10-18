class Meme < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :url, presence: true


end


#validations are going to be important. How do to validations?