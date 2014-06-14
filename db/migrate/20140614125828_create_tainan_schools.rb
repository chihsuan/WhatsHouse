class CreateTainanSchools < ActiveRecord::Migration
  def change
    create_table :tainan_schools do |t|
      t.string :fax
      t.string :schoolid
      t.string :tel
      t.string :district
      t.string :schooltype
      t.string :schoolname
      t.string :edu_code
      t.string :country
      t.string :region
      t.string :countryname
      t.string :merger
      t.float :lat
      t.float :lng
      t.string :addr
      t.string :schooltype2
      t.string :stage

      t.timestamps
    end
  end
end
