class CommentsController < ApplicationController
  def new
    if user_signed_in?
      @comment = Comment.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
  	@comment = Comment.new(comment_params)
  	if @comment.user_id != current_user.id
      redirect_to root_path
    else
      if @comment.save
  		  redirect_to comments_path
  	  else
  		  render 'new'
  	  end
    end
  end

  def comment_params
  	params.require(:comment).permit(:content, :user_id, :event_id)
  end

  def index
  	if user_signed_in?
      @comments = Comment.all
    else
      @comments = []
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      render 'edit'
    else
      if @comment.update_attributes(comment_params)
        redirect_to comment_path(@comment.id)
      else
        render 'edit'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end
end
