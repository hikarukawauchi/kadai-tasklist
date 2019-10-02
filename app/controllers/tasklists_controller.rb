class TasklistsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :create, :edit, :update, :destroy]
  before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    if logged_in?
      @tasklist = current_user.tasklists.build  # form_with 用
      @tasklists = current_user.tasklists.order(id: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    @tasklist = Tasklist.new
  end

  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    if @tasklist.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'tasklists/index'
    end
  end



  def edit
  end

  def update

    if @tasklist.update(tasklist_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @tasklist.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tasklist
    @tasklist = Tasklist.find(params[:id])
  end

  # Strong Parameter
  def tasklist_params
    params.require(:tasklist).permit(:content, :status)
  end
  
  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
  
end
