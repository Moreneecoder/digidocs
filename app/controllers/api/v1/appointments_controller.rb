class Api::V1::AppointmentsController < ApplicationController
  before_action :set_user_variables, only: %i[index show update destroy]
  before_action :prevent_doctor_from_creating_appointment, only: %i[create]
  before_action :prevent_doctor_from_updating_appointment, only: %i[update]
  before_action :prevent_doctor_from_deleting_appointment, only: %i[destroy]
  before_action :set_patient, only: %i[create]
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = @target_user.appointments if params[:user_id]
    @appointments = @target_user.inverse_appointments if params[:doctor_id]
    render json: @appointments
  end

  def create
    @appointment = @patient.appointments.build(appointment_params)
    @appointment.save!

    render json: @appointment, status: :created
  end

  def show
    render json: @appointment, status: :ok
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  def set_user_variables
    @target_user = User.patient.find(params[:user_id]) if params[:user_id]
    @target_user = User.doctor.find(params[:doctor_id]) if params[:doctor_id]
  end

  def set_patient
    @patient = User.patient.find(params[:user_id])
  end

  def set_appointment
    @appointment = @target_user.appointments.find(params[:id]) if params[:user_id]
    @appointment = @target_user.inverse_appointments.find(params[:id]) if params[:doctor_id]
  end

  def appointment_params
    # whitelist params
    params.permit(:user_id, :doctor_id, :title, :description, :time)
  end

  def prevent_doctor_from_creating_appointment
    return if params[:user_id]

    render json: { error: 'Doctors cannot create appointment' },
           status: :forbidden
  end

  def prevent_doctor_from_updating_appointment
    return if params[:user_id]

    render json: { error: 'Doctors cannot edit appointment' },
           status: :forbidden
  end

  def prevent_doctor_from_deleting_appointment
    return if params[:user_id]

    render json: { error: 'Doctors cannot delete appointment' },
           status: :forbidden
  end
end
