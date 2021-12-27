require 'date'

class Api::V1::AppointmentsController < ApplicationController
  include ApplicationHelper
  include AppointmentHelper

  before_action :set_target_user, only: %i[index show update destroy]
  before_action :prevent_doctor_from_creating_appointment, only: %i[create]
  before_action :prevent_doctor_from_updating_appointment, only: %i[update]
  before_action :prevent_doctor_from_deleting_appointment, only: %i[destroy]
  before_action :set_patient, only: %i[create]
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = get_user_appointments(params[:id])
    render json: @appointments, status: :ok
  end

  def create
    appointment = @patient.appointments.build(appointment_params)
    appointment.save!

    render json: appointment, status: :created
  end

  def show
    render json: get_appointment_with_user_data(@appointment), status: :ok
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    params.permit(:user_id, :doctor_id, :title, :description, :time)
  end

  def set_patient_params
    params.permit(:user_id)
  end

  def set_appointment_params
    params.permit(:id)
  end

  def set_patient
    @patient = User.patient.find(set_patient_params[:user_id])
  end

  def set_appointment
    @appointment = get_user_appointment(set_appointment_params[:id])
  end

  def render_forbidden(param)
    return unless doctor_url?

    render json: { error: "Doctors cannot #{param} appointment" },
           status: :forbidden
  end

  def prevent_doctor_from_creating_appointment
    render_forbidden('create')
  end

  def prevent_doctor_from_updating_appointment
    render_forbidden('update')
  end

  def prevent_doctor_from_deleting_appointment
    render_forbidden('delete')
  end
end
