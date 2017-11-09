# conventions over configuration
# i know the sql table is named games
require 'Geocoder'

class Game < ActiveRecord::Base 
	extend Geocoder::Model::ActiveRecord

	belongs_to :user

	has_many :Rsvps, dependent: :destroy # plural

	def address
		venue
	end

  # reverse_geocoded_by :latitude, :longitude
	geocoded_by :address
	after_validation :geocode


end