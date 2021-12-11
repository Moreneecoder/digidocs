class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :reject_attempt_to_create_doctor, only: %i[create]

  def index
    @patients = User.patient.all
    render json: @patients, status: :ok
  end

  def create
    @patient = User.create!(user_params)
    render json: { status: 201, user: @patient.id, message: "User #{@patient.name} created successfully" },
           status: :created
  end

  def show
    render json: {
      id: @patient.id,
      name: @patient.name,
      phone: @patient.phone,
      email: @patient.email
    }, status: :ok
  end

  def update
    @patient.update(user_params)
    head :no_content
  end

  def login
    @user = User.where(name: params[:name], email: params[:email]).first
    if @user
      render json: { status: 200, user: @user }, status: :ok
    else
      render json: { status: 404, message: 'User not found' }, status: :not_found
    end
  end

  def destroy
    @patient.destroy
    head :no_content
  end

  private

  def login_params
    params.require(:name, :email)
  end

  def user_params
    params.permit(:name, :phone, :email)
  end

  def set_user
    @patient = User.patient.find(params[:id])
  end

  def reject_attempt_to_create_doctor
    return unless params[:controller] == 'api/v1/users' && (params[:is_doctor] || params[:office_address])

    render json: { error: "Can't create doctor from a /#{params[:controller]} endpoint" },
           status: :forbidden
  end
end
