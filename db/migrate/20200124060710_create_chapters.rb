class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :name, null: false
      t.string :description
      t.references :topic, foreign_key: true
      t.timestamps
    end
  end
end
