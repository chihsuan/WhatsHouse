class ChangeCloStation < ActiveRecord::Migration
  def change
  	  rename_column :stations, :country, :city
  end
end
