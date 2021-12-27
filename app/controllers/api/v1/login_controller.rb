class Api::V1::LoginController < ApplicationController
  def create    
    @user = User.authenticate(login_params).first    
    if @user
      render json: { status: 200, user: @user }, status: :ok
    else
      render json: { status: 404, message: 'User not found' }, status: :not_found
    end
  end

  def login_params
    params.permit(:name, :email) 
  end
end
