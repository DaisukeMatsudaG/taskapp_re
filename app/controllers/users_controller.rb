class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]
  before_action :already_logged_in, only: [:new, :create]

  def show
    @user = User.find_by(id: session[:user_id])
    if !@user
      return redirect_to signin_path
    end
    #以下で全件を取得している。
    #current_user.tasks.allで全件、page~.でページネーションに関する記述
    #perで表示形式の変更
    status = params[:status]
    if status.present?
      @tasks = current_user.tasks.where(status: status).page(params[:page]).per(20)
    else
      @tasks = current_user.tasks.all.page(params[:page]).per(20)
    end
    #新規投稿用taskのインスタンス化
    
    #@tasks = @tasks.where(status: 'todo')
    
    @task = Task.new
  end

  def new
    @user = User.new
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