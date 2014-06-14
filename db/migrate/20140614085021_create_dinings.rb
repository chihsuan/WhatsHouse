class CreateDinings < ActiveRecord::Migration
  def change
    create_table :dinings do |t|
      t.string :diningid
      t.string :store_id
      t.string :name
      t.string :breif
      t.string :addr
      t.string :tel
      t.string :time
      t.float :lng
      t.float :lat
      t.string :code
      t.string :changetime

      t.timestamps
    end
  end
end
