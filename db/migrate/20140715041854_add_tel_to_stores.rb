class AddTelToStores < ActiveRecord::Migration
  def change
    add_column :stores, :tel, :string
  end
end
