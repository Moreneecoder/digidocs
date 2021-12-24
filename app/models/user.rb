class User < ApplicationRecord
  scope :doctor, -> { where(is_doctor: true) }
  scope :patient, -> { where(is_doctor: false) }

  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :appointments, dependent: :destroy
  has_many :inverse_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'

  def doctors
    appointments.includes(:doctor).map(&:doctor).compact
  end

  def patients
    inverse_appointments.includes(:user).map(&:user).compact
  end

  def get_appointment(id, url)
    if patient_url(url)
      appointments.find(id)
    elsif doctor_url(url)
      inverse_appointments.find(id)
    end
  end

  def get_appointments(_id, url)
    if patient_url(url)
      appointments.includes(:doctor).to_json({ include: :doctor })
    elsif doctor_url(url)
      inverse_appointments.includes(:user).to_json({ include: :user })
    end
  end

  def doctor_url(url)
    regex = %r{/api/v1/doctors}
    regex.match(url)
  end

  def patient_url(url)
    regex = %r{/api/v1/users}
    regex.match(url)
  end
end
