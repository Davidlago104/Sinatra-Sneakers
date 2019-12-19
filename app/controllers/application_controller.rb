require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'doggos'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

end
