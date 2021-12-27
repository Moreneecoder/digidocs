class Api::V1::UsersController < ApplicationController
  include ApplicationHelper
  include UserHelper

  before_action :set_user, only: %i[show update destroy]
  before_action :reject_attempt_to_create_doctor, only: %i[create]

  def index
    @patients = User.patient.all
    render json: @patients, status: :ok
  end

  def create
    @patient = User.create!(user_params)
    render json: { status: 201, user: @patient, message: "User #{@patient.name} created successfully" },
           status: :created
  end

  def show
    render json: @patient, status: :ok
  end

  def update
    @patient.update(user_params)
    head :no_content
  end

  def destroy
    @patient.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :phone, :email)
  end

  def set_user_params
    params.permit(:id)
  end

  def set_user
    @patient = User.patient.find(set_user_params[:id])
  end
end
