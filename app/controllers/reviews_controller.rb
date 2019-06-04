class ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
  end

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
  def update
    @review = Review.find(params[:id])

    @review.update(review_params)

    if @review.save
      redirect_to @review
    else
      render :edit
    end
  end
    
  def destroy
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      flash[:notice] = "review deleted."
    else
      flash[:notice] = "You crazy person, you don't own that!"
    end
    redirect_to book_path(@review.book_id)
  end

  private

  def review_params
    params.require(:review).permit(:description, :book_id, :rating)
  end
end
