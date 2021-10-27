class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :img
      t.string :genre
      t.string :location
      t.text :text
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
