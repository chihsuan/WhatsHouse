class CreateTainanMarkets < ActiveRecord::Migration
  def change
    create_table :tainan_markets do |t|
      t.string :phone
      t.string :business_hours
      t.string :name
      t.string :district
      t.float :lat
      t.float :lng
      t.string :address

      t.timestamps
    end
  end
end
