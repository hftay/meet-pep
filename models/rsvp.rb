# conventions over configuration
# i know the sql table is named rsvps
class Rsvp < ActiveRecord::Base 
	belongs_to :game
	belongs_to :user

end