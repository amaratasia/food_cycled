class CreateNutritions < ActiveRecord::Migration[5.1]
  def change
    create_table :nutritions do |t|
      t.string :name
      t.string :calorie
      t.string :fat
      t.string :food_name
      t.string :cusine

      t.timestamps
    end
  end
end
