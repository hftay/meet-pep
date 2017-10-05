require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'pepknows',
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

ActiveRecord::Base.establish_connection(options)
