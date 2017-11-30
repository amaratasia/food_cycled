class AddFieldToFoodOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :food_orders, :prep_date, :datetime
    add_column :food_orders, :expiry_date, :datetime
    add_column :food_orders, :spice_value, :integer
  end
end
