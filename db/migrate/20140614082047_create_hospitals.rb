class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :addr
      t.string :tel
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
