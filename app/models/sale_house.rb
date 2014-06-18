class SaleHouse < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	
	geocoded_by :address,
		 :latitude => :lat, :longitude => :lng
	after_validation :geocode
end
