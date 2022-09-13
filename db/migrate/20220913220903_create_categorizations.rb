class CreateCategorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :categorizations do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
