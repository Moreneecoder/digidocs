require 'date'

class Api::V1::AppointmentsController < ApplicationController
  before_action :set_target_user, only: %i[index show update destroy]
  before_action :prevent_doctor_from_creating_appointment, only: %i[create]
  before_action :prevent_doctor_from_updating_appointment, only: %i[update]
  before_action :prevent_doctor_from_deleting_appointment, only: %i[destroy]
  before_action :set_patient, only: %i[create]
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = @target_user.get_appointments(params[:id], url)
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

  def set_target_user
    @target_user = User.patient.find(params[:user_id]) if patient_url
    @target_user = User.doctor.find(params[:doctor_id]) if doctor_url
  end

  def set_patient
    @patient = User.patient.find(params[:user_id])
  end

  def set_appointment    
    @appointment = @target_user.get_appointment(params[:id], url);
  end

  def appointment_params
    params.permit(:user_id, :doctor_id, :title, :description, :time)
  end

  def url
    request.fullpath
  end

  def doctor_url
    regex = %r{/api/v1/doctors}
    regex.match(request.fullpath)
  end

  def patient_url
    regex = %r{/api/v1/users}
    regex.match(request.fullpath)
  end

  def render_forbidden(param)
    render json: { error: "Doctors cannot #{param} appointment" },
           status: :forbidden
  end

  def prevent_doctor_from_creating_appointment
    render_forbidden('create') if doctor_url
  end

  def prevent_doctor_from_updating_appointment
    render_forbidden('update') if doctor_url
  end

  def prevent_doctor_from_deleting_appointment
    render_forbidden('delete') if doctor_url
  end
end
