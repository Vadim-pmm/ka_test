class CommentsController < ApplicationController

  def index
    @comments = Comment.where(vacancy_id: params[:vacancy_id])
  end

  def create
    defaults_ = {vacancy_id: params[:vacancy_id],
                 user_id:    current_user.id,
                 rank:       0
    }
    @comment = Comment.create(comment_params.merge(defaults_))
    # @comment = Comment.create(comment_params.merge(vacancy_id: params[:vacancy_id]).merge(user_id: current_user.id))
  end

  def upvote
    Comment.upvote(params[:comment_id])
    @comment = Comment.find(params[:comment_id])
    render :create
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end