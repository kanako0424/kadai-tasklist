class TasksController < ApplicationController
  def index
      @tasks = Task.all
      #Task はapp/models/task.rbで定義されたクラス名
      #Task を使うことで継承されたクラスも使える。
      #それにより、rails のモデル操作がここでできる。
  end

  def show
    @task = Task.find(params[:id])
    #URLのパラメータやデータは全部paramsに代入されて受け取れる。
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
      flash[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = "タスクは更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    
    flash[:success] = "Messageは正常に削除されました"
    redirect_to task_url
  end
  
  private 
  #以下はstrong paramerter
  #送信されてきたデータを精査するためのもの
  #requireで Task モデルのフォームから得られるデータに関するものだと明示
  #permitで必要なカラムだけを選択する
  #strong parameterがないとセキュリティ上よくない
  def task_params
    params.require(:task).permit(:content)
  end
  
end
