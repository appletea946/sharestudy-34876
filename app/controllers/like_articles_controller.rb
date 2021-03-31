class LikeArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :move_to_user_show, only: [:create, :destroy]

  def create
    LikeArticle.create(user_id: current_user.id, article_id: params[:article_id])
    redirect_to article_path(params[:article_id])
  end

  def destroy
    LikeArticle.find_by_sql(['DELETE FROM like_articles WHERE user_id = :current_user_id AND article_id = :article_id',
                             { current_user_id: current_user.id, article_id: params[:article_id] }])
    redirect_to article_path(params[:article_id])
  end

  private

  def move_to_user_show
    redirect_to article_path(params[:article_id]) if current_user.id == Article.find(params[:article_id]).user_id
  end
end
