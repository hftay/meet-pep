     
require 'sinatra'
# require 'sinatra/reloader'
require 'pry'
require 'pg'
require_relative 'db_config'
require_relative 'models/game'
require_relative 'models/user'
require_relative 'models/rsvp'
require_relative 'models/league'
require_relative 'models/leaguestat'

enable :sessions # sinatra feature

helpers do # sinatra feature, create global(?) helpers methods 
	def current_user
		User.find_by(id: session[:user_id]) # returns user object
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

# ============ the home/index page ================

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
  @game = Game.find(params[:id])
  @rsvps = Rsvp.where(game_id: params[:id])

  erb :details
end

# ============ the user login page ================
get '/login' do
	@error_message =''
	# if !logged_in?
	# 	@error_message = 'Please log in or sign up to create a game.'
	# end
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

# ============ get signup page ================

get '/signup' do
  @error_message =''
  if logged_in?
    redirect "/"
  else
    erb :signup
  end
end

post '/signup' do
  user = User.new
  user.username = params[:username]   
  user.email = params[:email]
  if params[:password_digest] == params[:verify_password]
    user.password = params[:password_digest]
    user.save
    if user.save # if username and email is unique
      redirect "/"
    else
      @error_message = "Invalid username or email, please try again"
      erb :signup
    end
  else
    @error_message = "Error, please try again"
    erb :signup
  end
end

# ============ the creator access to game edit page ================

get '/game/:id/edit' do
  @game = Game.find(params[:id])
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
  redirect "/game/#{params[:id]}"
end

get '/game/:id/delete' do
  redirect '/' unless user_is_creator?
  @game = Game.find(params[:id])
  erb :delete_game
end

delete '/game/:id/delete' do
  @game = Game.find(params[:id])
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
  erb :about
end



# ============ STATS STATS STATS ================
# ============ get Stats page ================

get '/stats_home' do
  erb :stats_home
end

get '/league_create' do
  erb :league_create
end

post '/league_view' do
  @league = League.new
  @league.title = params[:title]
  #add constraint: can only create table if logged in? so then you can add @league.user = current_user.id
  @league.save
  #will need to check for duplicate titles
  num_rows = params[:num_players].to_i
  num_rows.times do 
    @leaguestat = Leaguestat.new
    @leaguestat.league = @league
    @leaguestat.save
 
  end
  redirect '/league_view'
end

get '/league_view' do
  @leagues = League.all
  erb :league_view
end

delete '/league/:id/delete' do
  @league = League.find(params[:id])
  @league.destroy
  redirect '/league_view'
end



get '/league/:id/stats_table_view' do
  @league = League.find(params[:id])
  @leaguestats = Leaguestat.where(league_id: @league.id)
  erb :stats_table_view
end


# ============ edit Player Stats page ================
get '/league/:id/stats_table_edit' do
  @league = League.find(params[:id])
  @leaguestats = Leaguestat.where(league_id: @league.id)
  erb :stats_table_edit
end

put '/league/:id/stats_table_edit' do
  @league = League.find(params[:id])
  @leaguestats = Leaguestat.where(league_id: @league.id)
  @record_to_update = @leaguestats.find_by(id: params[:leaguestat_id])
#need a validation to stop update if username is not in database
  @record_to_update.user = User.find_by(username: params[:user_id])
  @record_to_update.games_won = params[:games_won]
  @record_to_update.goals = params[:goals]
  @record_to_update.assists = params[:assists]
  @record_to_update.save
  redirect "league/#{params[:id]}/stats_table_view"
end


