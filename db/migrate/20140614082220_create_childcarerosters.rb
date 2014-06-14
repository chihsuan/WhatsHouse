class CreateChildcarerosters < ActiveRecord::Migration
  def change
    create_table :childcarerosters do |t|
      t.string :district
      t.string :name
      t.string :person_charge
      t.integer :size
      t.string :tel
      t.string :addr
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
