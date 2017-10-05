require 'active_record'


# use ENV database url first if possible
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

# if not, then use options
options = {
	adapter: 'postgresql',
	database: 'pepknows',
}

ActiveRecord::Base.establish_connection(options)
