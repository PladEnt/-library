class ReviewsController < ApplicationController
  def show
      @review = Review.find(params[:id])
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(review_params[:book_id])
    @review = current_user.reviews.build(review_params)

    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end
    
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "review deleted."
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:description, :book_id)
  end
end
