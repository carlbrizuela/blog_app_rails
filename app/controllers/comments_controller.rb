class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, except: [ :create, :index, :new]

  def index; end

  def new
    @comment = Comment.new
  end
   
  def create
    @comment = @article.comments.create(comment_params)
    if @comment.save
      redirect_to article_comments_path(@article, @comment), notice: "New comment added"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit; end

  def update   
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article, @comment), notice: "Comment updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_comments_path(@article, @comment), status: :see_other, notice: "Comment deleted"
  end

  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end
