class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :appointments, dependent: :destroy
  has_many :inverse_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'

  def doctors
    appointments.includes(:doctor).map { |appointment| appointment.doctor }.compact
  end

  def patients
    inverse_appointments.includes(:user).map { |appointment| appointment.user }.compact
  end


end
