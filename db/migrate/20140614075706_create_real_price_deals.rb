class CreateRealPriceDeals < ActiveRecord::Migration
  def change
    create_table :real_price_deals do |t|
      t.string :area
      t.string :things
      t.string :location
      t.float :size
      t.string :ciy_part
      t.string :non_city_part
      t.string :non_city_sub
      t.integer :date
      t.string :items
      t.string :tranf
      t.string :height
      t.string :tpye
      t.string :usage
      t.string :material
      t.integer :compele_year
      t.string :tranf_area
      t.string :house
      t.string :hall
      t.string :toilet
      t.string :part_house
      t.string :org
      t.integer :total_price
      t.float :price_per_m
      t.string :car_tpye
      t.string :car_area
      t.integer :car_price
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
