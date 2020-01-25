class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.string :description
      t.references :exam, foreign_key: true
      t.timestamps
    end
  end
end
