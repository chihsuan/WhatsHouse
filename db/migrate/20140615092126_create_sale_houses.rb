class CreateSaleHouses < ActiveRecord::Migration
  def change
    create_table :sale_houses do |t|
      t.string :owner
      t.string :address
      t.string :structure
      t.string :price
      t.string :size
      t.string :year
      t.string :floor
      t.string :tpye
      t.string :email
      t.string :tel
      t.string :breif

      t.timestamps
    end
  end
end
