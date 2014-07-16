class AddDataToPostOffices < ActiveRecord::Migration
  def change
    add_column :post_offices, :data, :string, :default => 'post_offices'
  end
end
