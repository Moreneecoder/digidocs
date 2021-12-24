class Appointment < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :time, presence: true

  belongs_to :user
  belongs_to :doctor, class_name: 'User'

  def with_user_data(url)
    if patient_url(url)    
      to_json({include: :doctor})
    elsif doctor_url(url)
      to_json({include: :user})
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
