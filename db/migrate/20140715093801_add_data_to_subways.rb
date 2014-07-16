class AddDataToSubways < ActiveRecord::Migration
  def change
    add_column :subways, :data, :string, :default => 'subways'
  end
end
