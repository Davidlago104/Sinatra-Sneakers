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
      @current_user ||= User.find_by(id: session[:user_id])
      #find, takes one single argument. find_by will take an id and anything, and give a key value pair
    end

    def logged_in?
      !!@current_user
    end

  end

  get "/" do
    erb :welcome
  end

end
