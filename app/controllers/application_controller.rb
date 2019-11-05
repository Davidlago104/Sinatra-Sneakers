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

  get "/hello" do
    @user = User.find_by(id: session[:user_id])
    @sneaker = Sneaker.find_by(id: session[:sneaker_id])
      erb :hello
    end

  post "/login" do
    # @sneaker = Sneaker.find_by(name: params[:name])
    user
    sneaker
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      session[:sneaker] = sneaker
      redirect "/hello"
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

  def user
    @user = User.find_by(name: params[:user][:name])
  end

  def sneaker
    @sneaker = Sneaker.find_by(name: params[:sneaker])
    binding.pry
  end

end
