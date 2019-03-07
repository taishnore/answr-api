class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :number_of_rounds, :current_round, :users, :rounds
end
