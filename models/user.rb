# conventions over configuration
# i know the sql table is named users
class User < ActiveRecord::Base 
	has_many :games, dependent: :destroy# plural
	has_many :Rsvps, dependent: :destroy# plural
	has_many :leagues
	has_many :leaguestats


	has_secure_password # it adds 2 methods to user objects, 
	#.password is the first method added
	#.authenticate is the second method added
end