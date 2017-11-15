class AddRoleAndTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 1
    add_column :users, :token, :string, index: true, unique: true
  end
end
