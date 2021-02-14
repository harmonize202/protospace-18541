class PrototypesController < ApplicationController
before_action :set_tweet, only: [:show, :edit] 

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    # ストロングパラメーターを格納した上でprototypesテーブルへ保存、かつ、変数@prototypeへ代入
    @prototype = Prototype.new(prototypes_params)
    # 保存の成功可否で条件分岐
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # Commentモデルのインスタンス変数の空箱を作成→ここにform_withメソッド内でのコメントのtextを入れる
    @comment = Comment.new
    # 該当のprototypeに紐づくコメントを全て取得する。user_idに紐づくcommentsを全て取得。userモデルに紐付いている。
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    prototype = Prototype.find(params[:id])
    unless current_user.id == prototype.user.id
      redirect_to action: :index
    end
  end
  
  def update
    # ストロングパラメーターを格納した上でprototypesテーブルへ保存、かつ、変数@prototypeへ代入
    prototype = Prototype.find(params[:id])
    # 保存の成功可否で条件分岐
    if prototype.update(prototypes_params)
      redirect_to prototype_path(prototype.id)
    else
      redirect_to edit_prototype_path(prototype.user_id)
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  
  def prototypes_params
    params.require(:prototype).permit(:title, :cacth_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
  def set_tweet
    # パラメーター情報の中のid情報に該当するprototypeテーブルのレコードを取得
    @prototype = Prototype.find(params[:id])
  end

end
