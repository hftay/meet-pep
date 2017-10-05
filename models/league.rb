# i know the sql table is named leagues
class League < ActiveRecord::Base 
	belongs_to :user

	has_many :leaguestats
end