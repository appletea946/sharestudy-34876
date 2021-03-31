class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, only: [:show]
  before_action :set_user, only: [:index, :search]

  def index
    @groups = Group.order(created_at: :desc)
    set_like_relations
  end

  def new
    @group = UsersGroup.new
  end

  def create
    @group = UsersGroup.new(group_params)
    if @group.valid?
      @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(@group.user_id)
    set_like_relations
    @tags = Tag.all
    @articles = @group.articles
  end

  def search
    @groups = Group.search(params[:switch], params[:keyword], current_user.id)
    set_like_relations
    render :index
  end

  def sign_up
    @group = Group.find(params[:format])
    unless UserGroupRelation.find_by_sql(['SELECT * FROM user_group_relations WHERE user_id = :user_id AND group_id = :group_id',
                                          { user_id: current_user.id, group_id: params[:format] }]).empty?
      redirect_to group_path(params[:format])
    end
  end

  def sign_in
    @group = Group.find(params[:group_id])
    if @group.password == params[:password]
      UserGroupRelation.create(sign_in_params)
      redirect_to group_path(@group.id)
    else
      redirect_to sign_up_groups_path(params[:group_id])

    end
  end

  private

  def group_params
    params.require(:users_group).permit(:name, :password).merge(user_id: current_user.id)
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

  def sign_in_params
    params.permit(:group_id).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to groups_path if UserGroupRelation.find_by_sql([
                                                               'SELECT * FROM user_group_relations WHERE user_id = :user_id AND group_id = :group_id', { user_id: current_user.id,
                                                                                                                                                         group_id: params[:id] }
                                                             ]).empty?
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
