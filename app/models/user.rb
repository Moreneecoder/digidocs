class User < ApplicationRecord
  scope :authenticate, ->(params) { where(name: params[:name], email: params[:email]) }
  scope :doctor, -> { where(is_doctor: true) }
  scope :patient, -> { where(is_doctor: false) }

  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :appointments, dependent: :destroy
  has_many :inverse_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'
end
