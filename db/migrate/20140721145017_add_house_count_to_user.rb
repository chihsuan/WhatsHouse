class AddHouseCountToUser < ActiveRecord::Migration
  def change
  	add_column :users, :rent_houses_count, :integer, :default => 0
  end
end
