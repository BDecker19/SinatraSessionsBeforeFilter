require 'rubygems'
require 'sinatra'
require 'pry'
require 'rack-flash'

enable :sessions
use Rack::Flash

set :db, {
  :dmgarland => "Dan",
  :c_trom => "Corey",
  :wisecracker100 => "JW",
  :whoisromangun => "Roman"
}

before '/new' do
  unless params[:password] == "coolbananas"
    flash[:notice] = "Sorry, the password is wrong, please try again."
    redirect '/login'
  end
end

before do
  @user = settings.db[params[:username]]
end

# Say hello and use the name of the associated user
#
get '/profile/:username' do
  if params[:username]
    erb :index, :locals => { :cool_bananas => @user }
  else
    404    
  end
end

get '/new' do
  erb :new, :locals => { :user => @user }
end

post '/new' do
  session[:current_user] = "Dan"
  erb :new
end

get '/login' do
  erb :login
end

post '/submit' do
  settings.db[params[:username].to_sym] = params[:name]
  redirect "/profile/#{params[:username]}"
end

not_found do
  "<h1>Sorry, we couldn't find that page...</h1>"
end

