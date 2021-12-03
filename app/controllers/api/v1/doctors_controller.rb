class Api::V1::DoctorsController < ApplicationController
    before_action :set_doctor, only: %i[show update destroy]

    def index
      @doctors = User.doctor.all
      render json: @doctors
    end

    def create
      
    end

    private

    def set_doctor
        @doctor = User.doctor.find(params[:id])
      end
end