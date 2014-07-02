class AddImgToSaleHouse < ActiveRecord::Migration
  def change
    add_column :sale_houses, :img, :string
  end
end
