require 'active_record'

# if not, then use options
options = {
	adapter: 'postgresql',
	database: 'pepknows'
}


# use ENV database url first if possible
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

# ActiveRecord::Base.establish_connection(options)
