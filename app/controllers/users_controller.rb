class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "サインアップしました"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "アカウントを編集しました"
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :icon, :icon_cache, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to blogs_path, notice: "権限がありません"
    end
  end
end
