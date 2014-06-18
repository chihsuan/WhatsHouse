class AddDataToRealPriceDeals < ActiveRecord::Migration
  def change
    add_column :real_price_deals, :data, :string, default:'real_price_deals'
  end
end
