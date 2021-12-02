class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  def index
    @users = User.where(is_doctor: nil).all

    render json: @users, status: :ok
  end

  def show
    render json: {
      name: @user.name,
      phone: @user.phone,
      email: @user.email
    }, status: :ok
  end

  private

  def user_params
    # whitelist params
    params.permit(:name, :phone, :email, :office_address, :is_doctor)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
