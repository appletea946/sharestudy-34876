class LikeArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :move_to_user_show, only: [:create, :destroy]

  def create
    like = LikeArticle.create(user_id: current_user.id, article_id: params[:article_id])
    render json: { like: like }
  end

  def destroy
    like = LikeArticle.find_by_sql(['DELETE FROM like_articles WHERE user_id = :current_user_id AND article_id = :article_id',
                                    { current_user_id: current_user.id, article_id: params[:article_id] }])
    render json: { like: like }
  end

  private

  def move_to_user_show
    redirect_to article_path(params[:article_id]) if current_user.id == Article.find(params[:article_id]).user_id
  end
end
