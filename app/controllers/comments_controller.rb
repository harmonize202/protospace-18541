class CommentsController < ApplicationController
  
  def create
    # ストロングパラメーターを格納した上でprototypesテーブルへ保存、かつ、変数@prototypeへ代入
    comment = Comment.create(comments_params)
    # 保存の成功可否で条件分岐
    if comment.save
      redirect_to prototype_path(params[:prototype_id])
    else
      redirect_to prototype_path(params[:prototype_id])
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
