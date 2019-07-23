class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :number_of_rounds, :current_round, :users, :rounds, :player_one_id, :player_two_id, :player_three_id
end
