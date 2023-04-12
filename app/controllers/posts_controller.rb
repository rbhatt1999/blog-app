class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end
  def show
    @post = Post.includes(:author).find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @post.comments
    @likes = @post.likes
  end
  def new
    @user = current_user
    @post = Post.new
  end
  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.author = @user
    if @post.save
      @post.update_post_counter
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.alert = 'sorry, something went wrong!'
      render :new
    end
  end
  def destroy
    @user = User.find(params[:user_id]) # current_user
    post = Post.find(params[:id])
    post.comments.destroy_all
    post.likes.destroy_all
    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end
  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
