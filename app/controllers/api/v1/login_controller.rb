class Api::V1::LoginController < ApplicationController
    def create
        @user = User.where(name: params[:name], email: params[:email]).first
        if @user
          render json: { status: 200, user: @user }, status: :ok
        else
          render json: { status: 404, message: 'User not found' }, status: :not_found
        end
      end
end