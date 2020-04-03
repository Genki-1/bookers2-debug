class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update]

  before_action :login_check, only: [:new, :edit, :update, :destroy, :index, :show, :create]

  def index
    @users = User.all
    @newbook = Book.new
  end


    def show
      @user = User.find(params[:id])
      @books = Book.all
      @newbook = Book.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user)
        flash[:notice] = "You have updated user successfully."
      else
        render :edit
      end
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if user_signed_in?
        if @user.id != current_user.id
            redirect_to user_path(current_user.id)
        end
    else
      redirect_to ("/users/sign_in")
    end
  end


    private


  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def login_check
      unless user_signed_in?
        redirect_to ("/users/sign_in")
      end
  end

end
