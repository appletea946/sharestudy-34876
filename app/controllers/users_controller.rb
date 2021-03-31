class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_tags, only: [:show, :search]
  before_action :move_to_show, only: [:edit, :update]

  def show
    # @articles = Article.where(["user_id = ?",@user.id])
    @articles = Article.find_by_sql([
                                      'SELECT * FROM articles WHERE user_id = :user_id AND id NOT IN (SELECT article_id FROM article_group_relations) ORDER BY created_at DESC', { user_id: @user.id }
                                    ])
    @groups = @user.groups
    set_like_relations
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def search
    @user = User.find(params[:format])
    set_like_relations
    @articles = Article.search(params[:switch], params[:tag_id], params[:keyword], user_signed_in? ? current_user.id : 0)
    @articles.select! do |item|
      item[:user_id] == @user.id && item.groups.empty?
    end

    render :show
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction, :image)
  end

  def move_to_show
    redirect_to user_path unless current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_like_relations
    @like = if user_signed_in?
              LikeUser.where(['give_user = :current_user_id AND receive_user = :user_id', {
                               current_user_id: current_user.id, user_id: @user.id
                             }])
            else
              []
            end
    @likes = LikeUser.where(['receive_user = ?', @user.id])
    @like_users = User.find_by_sql(['SELECT * FROM users WHERE id IN (SELECT receive_user FROM like_users WHERE give_user = ?)',
                                    @user.id])
    @like_articles = LikeArticle.find_by_sql([
                                               'SELECT * FROM like_articles WHERE article_id IN (SELECT id FROM articles WHERE user_id = ?)', @user.id
                                             ])
  end

  def set_tags
    @tags = Tag.all
  end
end
