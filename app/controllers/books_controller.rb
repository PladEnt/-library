class BooksController < ApplicationController
  def index
    if params[:auther]
      @auther = Auther.find_by(id: params[:auther])
      if @auther.nil?
        redirect_to authers_path, alert: "auther not found"
      else
        @books = @auther.books
      end
    else
      @books = Book.all
    end
  end

  def show
    if params[:auther]
      @auther = Auther.find_by(id: params[:auther])
      @book = @auther.books.find_by(id: params[:id])
      if @book.nil?
        redirect_to auther_books_path(@auther), alert: "book not found"
      end
    else
      @book = Book.find(params[:id])
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    @book.update(book_params)

    if @book.save
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "book deleted."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :auther_name)
  end
end
