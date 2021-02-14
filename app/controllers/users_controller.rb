class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # params[:id]のuserが投稿したデータだけが表示されるように記述
    # user_idに紐づくprototypesテーブルのデータを全て取得する。userモデルに紐付いている。
    @prototypes = @user.prototypes.includes(:user)
  end

end
