class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :country
      t.string :area
      t.string :station
      t.string :location
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
