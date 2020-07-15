class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
      @tasks = Task.order(id: :desc).page(params[:page]).per(20)
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
    @task = Task.new(task_params)
    #task_paramsは下のstrong parameterについてのもの
    #これで、Task.new(content: '...')となる
    
    if @task.save
      #@task.saveは成功するとtrue、失敗するとfalseを返すので条件分岐をする
      flash[:success] = "タスクが正常に投稿されました"
      redirect_to @task
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
    redirect_to tasks_url
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
  
end
