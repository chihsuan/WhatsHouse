class Subway < ActiveRecord::Base
  scope :area_select, -> (lat_lower, lat_upper, lng_lower, lng_upper) { where(:lat => lat_lower...lat_upper, :lng => lng_lower...lng_upper) }
end
