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
      @user = User.new
      render :login
    else
      redirect_to current_user
    end
  end

  def login
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "invalid login info"
      render :login
    end
  end

  def facebook_login
    @user = User.find_or_create_by(:email => auth['info']['email'])
    @user.name = auth['info']['name']
    @user.email = auth['info']['email']
    @user.name = auth['info']['name']
    if @user.password == nil
      @user.password = auth['uid']
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
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
    if @user.id == current_user.id
      @user.update(user_params)

      if @user.save
        redirect_to @user
      else
        render :edit
      end
    else
      flash[:notice] = "you don't own that user"
      redirect_to current_user
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.destroy
      session.clear
      flash[:notice] = "user deleted."
      redirect_to '/login'
    else
      flash[:notice] = "you don't own that user"
      redirect_to current_user
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
