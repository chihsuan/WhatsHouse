class CreateSubways < ActiveRecord::Migration
  def change
    create_table :subways do |t|
      t.string :city
      t.string :district
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
