class ReviewsController < ApplicationController
  def show
      @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
    
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "user deleted."
    redirect_to users_path
  end
end
