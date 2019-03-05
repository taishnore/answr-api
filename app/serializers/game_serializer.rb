class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :number_of_rounds, :is_game_in_play
end
