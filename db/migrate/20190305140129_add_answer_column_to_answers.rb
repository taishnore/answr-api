class AddAnswerColumnToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :answer_text, :string
  end
end
