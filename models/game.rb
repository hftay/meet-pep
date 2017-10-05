# conventions over configuration
# i know the sql table is named games
class Game < ActiveRecord::Base 
	belongs_to :user

	has_many :Rsvps, dependent: :destroy # plural

end