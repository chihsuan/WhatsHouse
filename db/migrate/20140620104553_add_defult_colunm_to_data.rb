class AddDefultColunmToData < ActiveRecord::Migration
  def change
  	 	add_column :stores, :data, :string, :default => 'stores'
  	 	add_column :hospitals, :data, :string, :default => 'hospitals'
  	 	add_column :drugstores, :data, :string, :default => 'drugstores'
  	 	add_column :childcarerosters, :data, :string, :default => 'childcarerosters'
  	 	add_column :stations, :data, :string, :default => 'stations'
  	 	add_column :tainan_schools, :data, :string, :default => 'tainan_schools'
  	 	add_column :dinings, :data, :string, :default => 'dinings'
  	 	add_column :police_stations, :data, :string, :default => 'police_stations'
  	 	add_column :tainan_markets, :data, :string, :default => 'tainan_markets'
  end
end
