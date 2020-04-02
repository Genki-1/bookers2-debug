class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  before_action :login_check, only: [:new, :edit, :update, :destroy, :index, :show, :create]


  def index
    @books = Book.all
    @book = Book.new
    @newbook = Book.new
  end

  def show
    @user = current_user
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have creatad book successfully."
    else
      @books = Book.all
      render("/books/index")
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
     if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
      @book = Book.find(params[:id])
      if user_signed_in?
        if @book.user_id != current_user.id
          redirect_to books_path
        end
      else
        redirect_to ("/users/sign_in")
      end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end


  def login_check
    unless user_signed_in?
      redirect_to ("/users/sign_in")
    end
  end

end
