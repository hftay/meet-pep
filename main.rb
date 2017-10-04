     
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
require_relative 'db_config'
require_relative 'models/game'
require_relative 'models/user'
require_relative 'models/GameType'
require_relative 'models/rsvp'



enable :sessions # sinatra feature

helpers do # sinatra feature, create global(?) helpers methods 
	def current_user
		User.find_by(id: session[:user_id])
		# returns user object
	end

	def logged_in?
		!!current_user #truthy if user obj returned
	end

	def user_is_creator?
		current_user==Game.find_by(id: params[:id]).user
	end

	def user_already_rsvp?
		!!Rsvp.find_by(game_id: params[:id], user_id: current_user.id)
	end

end

# ============ the home page ================

get '/' do
  @games = Game.all
  @games = @games.order('date asc')

  if logged_in?
    @rsvps = Rsvp.where(user_id: current_user.id)  # show user's rsvps
    @hosted = Game.where(user_id: current_user.id)
    erb :index
  else
    erb :about
  end

end



# ============ the game details page ================

get '/game/:id' do
	# binding.pry
  @game = Game.find(params[:id])
  @rsvps = Rsvp.where(game_id: params[:id])

  erb :details
end



# ============ the user login page ================
get '/login' do
	@error_message =''
	if !logged_in?
		@error_message = 'Please log in or sign up to create a game.'
	end
  erb :login
end

post '/session' do # verify user existence and authenticate
	user = User.find_by(email: params[:email])
	if user != nil && user.authenticate(params[:password])
		session[:user_id] = user.id # global hash
		redirect "/"
	else
		@error_message = 'Incorrect email or password'
		erb :login
	end
end

delete '/session' do # logout
	session[:user_id] = nil # => current_user becomes nil, logged_in becomes falsy
	redirect '/login'
end


# ============ the creator access to game edit page ================

get '/game/:id/edit' do
  @game = Game.find(params[:id])
  # binding.pry
  erb :edit_game
end

put '/game/:id/edit' do
  @game = Game.find(params[:id])
 	@game.title = params[:title]

  @date = params[:date]
 	@time = params[:time]
  date_time = DateTime.strptime("#{@date} #{@time} +1100", '%Y-%m-%d %H:%M %z')
 	@game.date = date_time
 	@game.venue = params[:venue]
 	@game.image_url = params[:image_url]
 	@game.description = params[:description]
  @game.save
  # binding.pry
  redirect "/game/#{params[:id]}"
end

get '/game/:id/delete' do
  redirect '/' unless user_is_creator?
  @game = Game.find(params[:id])
  erb :delete_game
end

delete '/game/:id/delete' do
  @game = Game.find(params[:id])
  # binding.pry
  @game.destroy
  redirect '/'
end

# ============ the creator game page ================

get '/create' do # this create page has similar structure to edit erb
  redirect '/login' unless logged_in?
  erb :create_game
end

post '/' do
  @game = Game.new
  @game.title = params[:title]

  @date = params[:date]
 	@time = params[:time]
  date_time = DateTime.strptime("#{@date} #{@time} +1100", '%Y-%m-%d %H:%M %z')
 	@game.date = date_time

 	@game.venue = params[:venue]
 	@game.image_url = params[:image_url]
 	@game.description = params[:description]
 	@game.user_id = current_user.id
  @game.save
	redirect '/'
end



# ============ rsvp to game page ================

put '/game/:id' do
  @rsvp = Rsvp.new
  @rsvp.user_id = current_user.id
  @rsvp.game_id = Game.find_by(id: params[:id]).id
  @rsvp.save
  redirect "/game/#{params[:id]}" # back to details page
end

delete '/game/:id' do
  rsvp = Rsvp.find_by(game_id: params[:id], user_id: current_user.id)
  rsvp.destroy
  redirect "/game/#{params[:id]}" # back to details page
end


# ============ get user's upcoming games page ================

get '/my_games' do
  @rsvps = Rsvp.where(user_id: current_user.id)  
  erb :user_profile
end

# ============ get About Pep page ================

get '/about' do
  "Hello World"
  erb :about
end

