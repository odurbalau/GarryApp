class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :interest_id

      t.timestamps
    end
    add_index :ratings, [:user_id, :created_at]
    add_index :ratings, [:interest_id, :created_at]
  end
end
