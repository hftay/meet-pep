# i know the sql table is named leaguestats
class Leaguestat < ActiveRecord::Base 
	belongs_to :league


	belongs_to :user
end