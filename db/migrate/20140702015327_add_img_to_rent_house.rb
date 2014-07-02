class AddImgToRentHouse < ActiveRecord::Migration
  def change
    add_column :rent_houses, :img, :string
  end
end
