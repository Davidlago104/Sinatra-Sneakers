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

  get "/login" do
      erb :login
    end

  get "/users/show" do
    #finds the user by their id and creates a session for them
      if @user = User.find_by(id: session[:user_id])
        erb :"users/show"
      else

        redirect to "/error"
      end
    end

  post "/users/show" do
    #creates a new sneaker with the user being attached.
    @sneaker = Sneaker.new(params[:sneaker])

    @sneaker.user_id

    if @sneaker.save
      redirect "/users/show"
    else
      #flash takes over and tells the user if there are any errors
      redirect "/login"
    end
  end

  post "/login" do
      @user = User.find_by(name: params[:user][:name])
      @sneakers = Sneaker.all
    #Checks to see if the user and authenticates the user making sure the password and user name match
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/show"
    else
      flash[:error] = "Something went wrong! Try again please."

      redirect "/login"
    end
  end

  get "/logout" do

    session.clear

    redirect to "/"
  end

  get "/error" do
    erb :error
  end


end
