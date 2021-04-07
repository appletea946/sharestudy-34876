class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :create]
  before_action :set_article, only: [:show, :edit, :update]
  before_action :set_tags, only: [:index, :search]
  before_action :set_rank_like_articles, only: [:index, :search]
  before_action :set_groups, only: [:new, :create]
  before_action :move_to_show, only: [:edit, :update]

  def index
    @articles = Article.find_by_sql(['SELECT * FROM articles WHERE id NOT IN (SELECT article_id FROM article_group_relations) ORDER BY created_at DESC'])
    # @articles = Article.order(created_at: :desc)
  end

  def new
    @article = ArticlesTag.new
  end

  def create
    @article = ArticlesTag.new(article_tag_params)
    if @article.valid?
      @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(@article.user_id)
    @comments = @article.comments.includes(:user)
    @comment = Comment.new
    if user_signed_in?
      @like = LikeUser.where(['give_user = :current_user_id AND receive_user = :article_user_id',
                              { current_user_id: current_user.id, article_user_id: @article.user.id }])
      @like_article = LikeArticle.where(['user_id = :current_user_id AND article_id = :article_id',
                                         { current_user_id: current_user.id, article_id: @article.id }])
    else
      @like = []
      @like_article = []
    end
    @likes = LikeUser.where(['receive_user = :user_id', { user_id: @user.id }])
    @like_articles = LikeArticle.find_by_sql([
                                               'SELECT * FROM like_articles WHERE article_id IN (SELECT id FROM articles WHERE user_id = :user_id)', { user_id: @user.id }
                                             ])
    @this_article_likes = LikeArticle.find_by_sql(['SELECT * FROM like_articles WHERE article_id = :article_id',
                                                   { article_id: @article.id }])
    
    if user_signed_in?
      @users_relations = LikeUser.new(give_user: current_user.id, receive_user: @user.id);
      @user_article_relations = LikeArticle.new();
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article.id)
    else
      article_params.each do |key, value|
        @article[key] = value
      end
      render :edit
    end
  end

  def search
    @articles = Article.search(params[:switch], params[:tag_id], params[:keyword], params[:current_user_id])
    @articles.select! do |item|
      item.groups.empty?
    end
    render :index
  end

  def tag_search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  private

  def article_tag_params
    params.require(:articles_tag).permit(:title, :content, :name, :group_id).merge(user_id: current_user.id)
  end

  def article_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_tags
    @tags = Tag.all
  end

  def set_groups
    @groups = current_user.groups
  end

  def move_to_show
    redirect_to article_path(@article.id) unless current_user.id == @article.user.id
  end

  def set_rank_like_articles
    @rank_like_articles = Article.find_by_sql('SELECT articles.* FROM articles JOIN like_articles ON articles.id = like_articles.article_id GROUP BY articles.id ORDER BY COUNT(*) DESC LIMIT 12')
  end
end
