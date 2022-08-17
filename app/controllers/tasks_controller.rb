class TasksController < ApplicationController
  before_action :require_logged_in
  before_action :set_task, only: [:edit, :update, :destroy, :update_status, :show, :update_status]
  before_action :set_tasks, only: [:all_done_destroy]
  before_action :correct_user, only: [:edit, :update, :destroy, :update_status]

  def update_status
    @task =Task.find(params[:id])
    @task.update(status: params[:status])
    redirect_to edit_task_path(@task), notice: "ステータスを変更しました"
  end

  def button_update_status
    @task =Task.find(params[:id])
    @task.update(status: params[:status])
    redirect_to root_path, notice: "ステータスを変更しました"
  end


  def create
    @task = current_user.tasks.build(task_params)
    # user_id
    # title, author. publisher, review
    # Book.new(user_id: sessionc[:user_id],~~~)と書くのと同じことである
    if @task.save
      flash[:success] = "登録しました"
      redirect_to root_path
    else
      flash[:danger] = "登録できませんでした"
      redirect_to root_path
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to root_path
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "削除しました"
    redirect_to root_path
  end

  def search
    #@tasks = Task.where(content: params[:keyword])
    #@keyword = params[:keyword]
    deadline_year = params["deadline(1i)"]
    deadline_month = params["deadline(2i)"]
    deadline_day = params["deadline(3i)"]
    deadline = "#{deadline_year}-#{deadline_month}-#{deadline_day}"
    redirect_to root_path(keyword: params[:keyword] ,deadline: deadline)
  end

  def button_update_status
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to root_path
    else
      flash.now[:danger] = "更新できませんでした"
      redirect_to root_path
    end
  end


  def all_done_destroy
    @tasks.destroy_all
    flash[:success] = "削除しました"
    redirect_to root_path
  end
  

  private
  def task_params
    params.require(:task).permit(:content,:deadline,:status,:estimated_time)
  end



  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks
    @tasks = Task.where(user_id: current_user.id, status: 'done')
  end

  def correct_user
    unless @task.user_id == current_user.id
      redirect_to root_path
    end
  end
end