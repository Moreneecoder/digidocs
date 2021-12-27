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
    render json: @appointment.with_user_data(url), status: :ok
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

  def set_patient
    @patient = User.patient.find(params[:user_id])
  end

  def set_appointment
    @appointment = get_user_appointment(params[:id])
  end

  def appointment_params
    params.permit(:user_id, :doctor_id, :title, :description, :time)
  end

  def render_forbidden(param)
    render json: { error: "Doctors cannot #{param} appointment" },
           status: :forbidden
  end

  def prevent_doctor_from_creating_appointment
    render_forbidden('create') if doctor_url?
  end

  def prevent_doctor_from_updating_appointment
    render_forbidden('update') if doctor_url?
  end

  def prevent_doctor_from_deleting_appointment
    render_forbidden('delete') if doctor_url?
  end
end
