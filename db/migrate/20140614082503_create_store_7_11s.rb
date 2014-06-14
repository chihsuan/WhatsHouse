class CreateStore711s < ActiveRecord::Migration
  def change
    create_table :store_7_11s do |t|
      t.string :address
      t.string :code
      t.string :district
      t.string :name
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
