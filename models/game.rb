# conventions over configuration
# i know the sql table is named games

require 'geocoder'
require 'Geocoder'

class Game < ActiveRecord::Base 
	extend Geocoder::Model::ActiveRecord
	extend geocoder::Model::ActiveRecord

	belongs_to :user

	has_many :Rsvps, dependent: :destroy # plural

	def address
		venue
	end

  def self.included(base)
  	base.extend(self) 
  end 

	geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
	after_validation :geocode, :if => :address_changed?


end