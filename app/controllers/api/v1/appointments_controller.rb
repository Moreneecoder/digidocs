class Api::V1::AppointmentsController < ApplicationController
  before_action :set_user_variables, only: %i[index show update destroy]
  def index
    @appointments = @target_user.appointments
    render json: @appointments
  end

  def create; end

  def set_user_variables
    @target_user = User.patient.find(params[:user_id]) if params[:user_id]
    @target_user = User.doctor.find(params[:doctor_id]) if params[:doctor_id]
  end
end
