class TasksController < ApplicationController
  before_action :require_logged_in
  before_action :set_task, only: [:update, :destroy,:show]
  before_action :correct_user, only: [:update, :destroy]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "追加しました"
      redirect_back(fallback_location: root_path) 
    else
      flash[:danger] = "追加できませんでした"
      redirect_back(fallback_location: root_path) 
    end
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "『#{@task.content}』を更新しました"
      redirect_back(fallback_location: root_path) 
  
    else
      flash.now[:danger] = "更新できませんでした"
      redirect_back(fallback_location: root_path) 
    end
  end

  def destroy
    content = @task.content
    @task.destroy
    flash[:success] = "『#{content}』を削除しました"
    redirect_back(fallback_location: root_path) 
  end

  def search
    #deadlineの3つ分かれているパラメータの受け取り
    deadline_year = params["deadline(1i)"]
    deadline_month = params["deadline(2i)"]
    deadline_day = params["deadline(3i)"]
    # deadlineを指定していればdeadlineオブジェクトを生成
    if deadline_year.present? & deadline_month.present? & deadline_day.present? 
      deadline = "#{deadline_year}-#{deadline_month}-#{deadline_day}"
    # そうでなければnil
    else
      deadline = nil
    end
    redirect_to root_path(keyword: params[:keyword] ,deadline: deadline)
  end  

  private
  def task_params
    params.require(:task).permit(:content,:deadline,:status,:estimated_time)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def correct_user
    unless @task.user_id == current_user.id
      redirect_to root_path
    end
  end
end