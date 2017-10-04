require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'pepknows',
}

ActiveRecord::Base.establish_connection(options)