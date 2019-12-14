require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
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
      if @user = User.find_by(id: session[:user_id])
        erb :"users/show"
      else
        redirect to "/error"
      end
    end

  post "/users/show" do
    @sneaker = Sneaker.new(params[:sneaker])

    @sneaker.user_id
    binding.pry
    if @sneaker.save
      redirect "/users/show"
    else
      erb :error
    end
  end

  post "/login" do
      @user = User.find_by(name: params[:user][:name])
      @sneakers = Sneaker.all
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/show"
    else
      redirect "/error"
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
