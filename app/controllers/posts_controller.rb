class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @pagy, @posts = pagy(current_user.posts.order(id: :desc), items: 9)
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
  
  def ranking
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  def cake
    @cake_ranks = Post.joins(:favorites).group('post_id').where(genre: 'cake').order('count(post_id) desc').limit(3)
  end
  
  def cookie
    @cookie_ranks = Post.joins(:favorites).group('post_id').where(genre: 'cookie').order('count(post_id) desc').limit(3)
  end
  
  def ice
    @ice_ranks = Post.joins(:favorites).group('post_id').where(genre: 'ice').order('count(post_id) desc').limit(3)
  end
  
  def others
    @others_ranks = Post.joins(:favorites).group('post_id').where(genre: 'others').order('count(post_id) desc').limit(3)
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
