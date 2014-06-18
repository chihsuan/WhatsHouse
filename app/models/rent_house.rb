class RentHouse < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	default_scope -> { order('created_at DESC') }
	
	geocoded_by :address,
		 :latitude => :lat, :longitude => :lng
	after_validation :geocode


end
