class CreatePoliceStations < ActiveRecord::Migration
  def change
    create_table :police_stations do |t|
      t.string :country
      t.string :district
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
