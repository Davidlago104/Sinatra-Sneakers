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

# user currently logged in, make this method memorize, wont load more than once
  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    # def stop_them(session)
    #   @current_user ||=
    # end
  end
  # add error messages to edit blocks -done
  # add to delete messages and delete things that arent theirs
  # anytime looking for a user thats logged in we use current user instead -done
  # we're gonna talk about how we reach to and from database
  # we're gonna talk about how the current user helper helps
  get "/" do
    erb :welcome
  end

end
