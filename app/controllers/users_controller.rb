class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 9)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 9)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
        flash[:success] = "Profileは正常にUpdateされました"
        redirect_to users_url
    else
        flash.now[:danger] = "ProfileはUpdateされませんでした"
        render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
    #loginしているuserのidを取得
    @user = User.find(params[:id])
    #そのuserがフォローしている人たちを取得して、一覧表示
    @pagy,@likes = pagy(@user.favorited_posts.order(created_at: :desc))
    #フォローしている人たちの人数をカウント
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_edit_params
    params.require(:user).permit(:avater, :introduction)
  end
  
end
