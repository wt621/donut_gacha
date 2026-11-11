class AddGroupNameAndPriceToDonuts < ActiveRecord::Migration[7.2]
  def change
    add_column :donuts, :group_name, :string
    add_column :donuts, :price, :integer
  end
end
