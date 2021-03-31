class LikeUsersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :move_to_user_show, only: [:create, :destroy]

  def create
    LikeUser.create(give_user: current_user.id, receive_user: params[:user_id])
    redirect_to user_path(params[:user_id])
  end

  def destroy
    LikeUser.find_by_sql(['DELETE FROM like_users WHERE give_user = :current_user_id AND receive_user = :receive_user',
                          { current_user_id: current_user.id, receive_user: params[:user_id] }])
    redirect_to user_path(params[:user_id])
  end

  private

  def move_to_user_show
    redirect_to user_path(params[:user_id]) if current_user.id == params[:user_id]
  end
end
