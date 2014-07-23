class AddIndexsToTables < ActiveRecord::Migration
  def change
  	add_index :hospitals, :lat
  	add_index :hospitals, :lng
  	add_index :stations, :lat
  	add_index :stations, :lng
  	add_index :subways, :lat
  	add_index :subways, :lng
  end
end
