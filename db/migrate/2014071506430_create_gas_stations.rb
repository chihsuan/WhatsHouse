class CreateGasStations < ActiveRecord::Migration
  def change
    create_table :gas_stations do |t|
      t.string :city
      t.string :district
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
