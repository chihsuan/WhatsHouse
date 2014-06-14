class CreateDrugstores < ActiveRecord::Migration
  def change
    create_table :drugstores do |t|
      t.string :state
      t.string :type
      t.string :name
      t.string :country
      t.string :district
      t.string :location
      t.string :tel
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
