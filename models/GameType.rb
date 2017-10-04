# conventions over configuration
# i know the sql table is named game_types
class GameType < ActiveRecord::Base 
	belongs_to :game
end