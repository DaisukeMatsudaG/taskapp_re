class UsersController < ApplicationController
#  before_action :require_logged_in, only: [:show]
#  before_action :already_logged_in, only: [:new, :create]

  def show
    @user = User.last
  end

  def new
    @user = User.new##なに？
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = '登録しました' #一回だけ表示
      redirect_to root_path 
    else
      flash.now[:danger] = '登録できませんでした'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :name, :birthday, :email, :password, :password_confirmation
    )
  end
end