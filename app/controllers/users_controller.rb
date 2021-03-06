class UsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user
    @book = Book.new
    @books = Book.all
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @thisweek_book = @books.created_this_week
    @lastweek_book = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_add_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "See you!!!"
    redirect_to root_path
  end

  private

  def user_add_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    end
  end
end
