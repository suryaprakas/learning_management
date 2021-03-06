class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :title, null: false
      t.string :description
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
