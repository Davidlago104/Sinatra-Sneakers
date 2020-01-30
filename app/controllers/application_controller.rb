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

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
      !!@current_user
    end

  end

  get "/" do
    erb :welcome
  end

end
