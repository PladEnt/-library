class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def login_form
    if !logged_in?
      render :login
    else
      redirect_to @user
    end
  end

  def login
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "User not found."
      redirect_to '/login'
    end
  end

  def facebook_login
    if @user = User.find_by(:name => auth['info']['name'])
      session[:user_id] = @user.id

      redirect_to @user
    else
      flash[:notice] = "User not found."
      redirect_to '/login'
    end
  end

  def logout
    session.clear
    redirect_to '/login'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)

    if @user.save
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.books.each do |book|
      book.reviews.each do |review|
        review.destroy
      end
      book.destroy
    end
    @user.destroy
    session.clear
    flash[:notice] = "user deleted."
    redirect_to '/login'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
