class AddPlayerNumbersToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :player_one_id, :integer
    add_column :games, :player_two_id, :integer
    add_column :games, :player_three_id, :integer
  end
end
