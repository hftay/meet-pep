# conventions over configuration
# i know the sql table is named games

# require 'geocoder'
require 'geocoder'

class Game < ActiveRecord::Base 
	extend Geocoder::Model::ActiveRecord

	belongs_to :user

	has_many :Rsvps, dependent: :destroy # plural

	def address
		venue
	end

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address

end