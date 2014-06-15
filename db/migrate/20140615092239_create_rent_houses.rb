class CreateRentHouses < ActiveRecord::Migration
  def change
    create_table :rent_houses do |t|
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
      t.string :note

      t.timestamps
    end
  end
end
