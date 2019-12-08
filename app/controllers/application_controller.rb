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
      if @user = User.find_by(id: session[:user_id])
        erb :hello
      else
        redirect to "/error"
      end
    end

  post "/hello" do
    @sneaker = Sneaker.new(params[:sneaker])

    @sneaker.user_id

    if @sneaker.save
      redirect "/hello"
    else
      erb :error
    end
  end

  post "/login" do
      @user = User.find_by(name: params[:user][:name])
      @sneakers = Sneaker.all
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/hello"
    else
      redirect "/error"
    end
  end

  patch "/sneakers/:id" do
    #get params from url
    @sneaker = Sneaker.find_by(id: params[:id]) #define variable to edit

    @sneaker.update(params[:sneaker]) #assign new attributes

    if @sneaker.save #saves new sneaker or returns false if unsuccessful
      redirect '/sneakers' #redirect back to sneakers index page
    else
      erb :'sneakers/edit' #show edit sneaker view again(potentially displaying errors)
    end
  end

  # DELETE: /sneakers/5/delete
  delete "/sneakers/:id" do
    #get params from url
    @sneaker = Sneaker.find_by(params[:sneaker]) #define sneaker to delete

    @sneaker.destroy #delete sneaker

    redirect '/sneakers' #redirect back to sneakers index page
  end

  get "/logout" do

    session.clear

    redirect to "/"
  end

  get "/error" do
    erb :error
  end


end
