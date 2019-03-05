class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :current_round, default: 1
      t.boolean :is_game_in_play, default: false
      t.integer :number_of_rounds, default: 0
      t.timestamps
    end
  end
end
