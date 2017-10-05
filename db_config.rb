require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'pepknows'
}

# use ENV database url first if possible, if not, then use options
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)