class AddAllergyToNutritions < ActiveRecord::Migration[5.1]
  def change
    add_column :nutritions, :allergy, :string
  end
end
