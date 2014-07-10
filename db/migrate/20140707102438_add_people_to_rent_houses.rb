class AddPeopleToRentHouses < ActiveRecord::Migration
  def change
    add_column :rent_houses, :people, :integer
  end
end
