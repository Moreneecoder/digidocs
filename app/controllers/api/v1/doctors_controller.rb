class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show update destroy]
  before_action :reject_attempt_to_create_user, only: %i[create]

  def index
    @doctors = User.doctor.all
    render json: @doctors
  end

  def create
    @doctor = User.create!(user_params)
    render json: { status: 201, doctor: @doctor, message: "Doctor #{@doctor.name} created successfully" },
           status: :created
  end

  def show
    render json: {
      id: @doctor.id,
      name: @doctor.name,
      phone: @doctor.phone,
      email: @doctor.email,
      office_address: @doctor.office_address
    }, status: :ok
  end

  def update
    @doctor.update(user_params)
    head :no_content
  end

  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :phone, :email, :office_address, :is_doctor)
  end

  def set_doctor
    @doctor = User.doctor.find(params[:id])
  end

  def reject_attempt_to_create_user
    return unless params[:controller] == 'api/v1/doctors' && (!params[:is_doctor] || !params[:office_address])

    render json: { error: "Can't create user from a /#{params[:controller]} endpoint" },
           status: :forbidden
  end
end
