class CreateDonuts < ActiveRecord::Migration[7.2]
  def change
    create_table :donuts do |t|
      t.string :name
      t.string :rarity
      t.text :description

      t.timestamps
    end
  end
end
