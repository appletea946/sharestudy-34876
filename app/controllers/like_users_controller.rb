class LikeUsersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :move_to_user_show, only: [:create, :destroy]

  def create
    like = LikeUser.create(give_user: current_user.id, receive_user: params[:user_id])
    render json: { like: like }
  end

  def destroy
    like = LikeUser.find_by_sql(['DELETE FROM like_users WHERE give_user = :current_user_id AND receive_user = :receive_user',
                                 { current_user_id: current_user.id, receive_user: params[:user_id] }])
    render json: { like: like }
  end

  private

  def move_to_user_show
    redirect_to user_path(params[:user_id]) if current_user.id == params[:user_id]
  end
end
