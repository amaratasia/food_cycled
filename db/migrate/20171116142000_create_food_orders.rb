class CreateFoodOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :food_orders do |t|
      t.references :user, foreign_key: true
      t.string :food_name
      t.integer :status
      t.integer :picked_by
      t.string :image_url

      t.timestamps
    end
  end
end
