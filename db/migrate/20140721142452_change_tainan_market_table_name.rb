class ChangeTainanMarketTableName < ActiveRecord::Migration
  def change
  	rename_table :tainan_markets, :markets
  end
end
