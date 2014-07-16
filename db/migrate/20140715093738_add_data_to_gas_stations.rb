class AddDataToGasStations < ActiveRecord::Migration
  def change
    add_column :gas_stations, :data, :string, :default => 'gas_stations'
  end
end
