class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id]) # プロトタイプを取得
    @comment = @prototype.comments.build(comment_params) # プロトタイプに紐づいたコメントを作成
    @comment.user = current_user # コメントのユーザーを設定
  
    if @comment.save
      redirect_to prototype_path(@prototype), notice: "コメントを投稿しました"
    else
      @comments = @prototype.comments.includes(:user) # 既存のコメントを取得
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
