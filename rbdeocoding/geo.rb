require 'rails/all'
require 'geokit'

module GeoCoding
	def self.addressTransGeo(address)
		a=Geokit::Geocoders::GoogleGeocoder.geocode address
		puts(a.ll)
	end
end
