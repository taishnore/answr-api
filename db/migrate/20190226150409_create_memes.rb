class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|
      t.string :title
      t.text :url
      t.integer :user_id

      t.timestamps
    end
  end
end
