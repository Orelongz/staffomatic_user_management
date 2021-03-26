class UsersController < ApplicationController
  before_action :set_user, only: %i[archive unarchive]

  def index
    render jsonapi: User.active
  end

  def archive
    if @user.soft_delete(current_user.id)
      render json: { message: 'User has been archived' }, status: :ok
    else
      render jsonapi_errors: @user.errors, status: :unprocessable_entity
    end
  end

  def unarchive
    if @user.recover
      render json: { message: 'User has been unarchived' }, status: :ok
    else
      render jsonapi_errors: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])

    return user_not_found unless @user
  end

  def user_not_found
    render json: { message: 'User not found' }, status: :not_found
  end
end
