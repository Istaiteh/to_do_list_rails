class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
