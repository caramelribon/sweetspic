class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @pagy, @posts = pagy(current_user.posts.order(id: :desc))
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_url
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:img, :genre, :location, :text)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
