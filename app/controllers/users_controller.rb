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
    if @user.save#saveメソッドを行われる。それで何か起こるかどうか問題。
      session[:user_id] = @user.id
      flash[:success] = '登録しました' #ここも謎
      redirect_to root_path #ここ謎　＃’/’にリダイレクトしてくれるんだよね
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