class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :dinings, :addr, :address
  	rename_column :hospitals, :addr, :address
  	rename_column :stations, :location, :address
  	rename_column :childcarerosters, :addr, :address
  	rename_column :drugstores, :location, :address
  	rename_column :tainan_schools, :addr, :address
  end
end
