class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.string :keyword, limit: 255, null: false
      t.timestamps
    end
  end
end
