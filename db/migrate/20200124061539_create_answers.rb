class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :is_skipped, default: false
      t.references :option, foreign_key: true
      t.boolean :is_answer_correct
      t.timestamps
    end
  end
end
