class UsersController < ApplicationController


  get "/login" do
      erb :login
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

  # GET: /users
  get "/users" do
    @users = User.all
    erb :"/users/index"
  end

  # GET: /users/new
  get "/users/new" do
    @sneakers = Sneaker.all
    erb :"/users/new"
  end

  # POST: /users
  post "/users" do
    #below works with properly formatted params in HTML form
    @user = User.new(params[:user]) #create new user
    @user.save
    session[:user_id] = @user.id
    redirect '/users'
    # redirect "/users"
  end

  get "/users/show" do
    #finds the user by their id and creates a session for them
    @user = User.find_by(id: session[:user_id])
    erb :"users/show"

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

  # GET: /users/5
  get "/users/:id" do
    #gets params from url
    @user = User.find_by(params[:id]) #define instance variable for view
    erb :"users/show" #show single user view
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    #get params from url
    @user = User.find(params[:id]) #define intstance variable for view
    erb :"/users/edit"
  end


  # PATCH: /users/5
  patch "/users/:id" do
    @user = User.find(params[:id]) #define variable to edit

    @user.assign_attributes(params[:user]) #assign new attributes

    if @user.save #saves new user or returns false if unsuccessful
      redirect '/users' #redirect back to users index page
    else
      erb :'users/edit' #show edit user view again(potentially displaying errors)
    end
    # redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    #get params from url
    @user = User.find(params[:id]) #define user to delete

    @user.destroy #delete user
    redirect "/users"
  end
end
