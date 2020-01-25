class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :description
      t.integer :question_type, null: false, default: 0
      t.references :chapter, foreign_key: true
      t.timestamps
    end
  end
end
