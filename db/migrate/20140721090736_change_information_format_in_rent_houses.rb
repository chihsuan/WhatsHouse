class ChangeInformationFormatInRentHouses < ActiveRecord::Migration
  def change
  	rename_column :rent_houses, :breif, :information
  	change_column :rent_houses, :information, :text
  end
end
