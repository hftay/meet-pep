# conventions over configuration
# i know the sql table is named games
class Game < ActiveRecord::Base 
	belongs_to :user

	has_many :Rsvps, dependent: :destroy # plural

	def full_street_address
		venue
	end

	geocoded_by :full_street_address

end