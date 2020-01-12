class SneakersController < ApplicationController

  # GET: /sneakers
  get "/sneakers" do
    @sneakers = Sneaker.all
    erb :"/sneakers/index"
  end

  # GET: /sneakers/new
  get "/sneakers/new" do
    @users = User.all
    erb :"/sneakers/new"
  end


  # POST: /sneakers
  post "/sneakers" do
    #below works with properly formatted params in HTML form
    @sneaker = Sneaker.new(params[:sneaker]) #create new sneaker

    @sneaker.user_id

    if @sneaker.save #saves new sneaker or returns false if unsuccessful
      redirect '/sneakers/#{@sneaker.id}' #redirect back to sneakers index page
    else
      erb :'sneakers/new' # show new sneakers view again(potentially displaying errors)
    end
  #   redirect "/sneakers"
  end

  post "/sneakers/edit" do

    #finds the sneaker and goes within the sneaker nest and looks for the id
    redirect "/sneakers/#{params[:sneaker][:id]}/edit"
  end

  get "/sneakers/:id" do
    #gets params from url
    @sneaker = Sneaker.find(params[:id])#define instance variable for view

    erb :'sneakers/show' #show single sneaker view
  end

  # GET: /sneakers/5/edit
  get "/sneakers/:id/edit" do
    #get params from url
    @sneaker = Sneaker.find_by(id: params[:id]) #define intstance variable for view
    if @sneaker.user_id == current_user.id
      erb :'sneakers/edit' #show edit sneaker view
    else
      flash[:error] = "You don't have access to that particular sneaker"
      redirect '/users/show'
    end
  end
  #   erb :"/sneakers/edit.html"


  # PATCH: /sneakers/5
  patch "/sneakers/:id" do
    #get params from url
    @sneaker = Sneaker.find_by(id: params[:id]) #define variable to edit

    @sneaker.update(params[:sneaker]) #assign new attributes



    if @sneaker.user_id == current_user.id #saves new sneaker or returns false if unsuccessful
      @sneaker.save
      flash[:good] = "Your sneaker has been updated!"
      redirect '/users/show' #redirect back to sneakers index page
    else
      redirect '/users/show' #show edit sneaker view again(potentially displaying errors)
    end
  end

  # DELETE: /sneakers/5/delete
  delete "/sneakers/:id" do
    #get params from url
    @sneaker = Sneaker.find_by(params[:sneaker]) #define sneaker to delete

    @sneaker.destroy #delete sneaker
    flash[:good] = "Your sneaker has been deleted!"
    redirect '/users/show' #redirect back to sneakers index page
  end

end
