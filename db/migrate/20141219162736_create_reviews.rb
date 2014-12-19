class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :body, null:false
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
