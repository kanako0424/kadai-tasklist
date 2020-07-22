class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(20)
    end
      #Task はapp/models/task.rbで定義されたクラス名
      #Task を使うことで継承されたクラスも使える。
      #それにより、rails のモデル操作がここでできる。
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    #task_paramsは下のstrong parameterについてのもの
    #これで、Task.new(content: '...')となる
    
    if @task.save
      #@task.saveは成功するとtrue、失敗するとfalseを返すので条件分岐をする
      flash[:success] = "タスクが正常に投稿されました"
      redirect_to root_url
    else 
      flash.now[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to root_url
    #requetを発生する。アンカータグと同じ
    #相対パスをいれる。
    #redirect_toは_pathでもいけるけど、よく使うのは_url
  end
  
  private 
  #以下はstrong paramerter
  #送信されてきたデータを精査するためのもの
  #requireで Task モデルのフォームから得られるデータに関するものだと明示
  #permitで必要なカラムだけを選択する
  #strong parameterがないとセキュリティ上よくない
  
  def set_task
    @task = Task.find(params[:id])
    #URLのパラメータやデータは全部paramsに代入されて受け取れる。
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
