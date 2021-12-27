module AppointmentHelper
  def get_user_appointments(_id)
    if patient_url?
      @target_user.appointments.includes(:doctor).to_json({ include: :doctor })
    elsif doctor_url?
      @target_user.inverse_appointments.includes(:user).to_json({ include: :user })
    end
  end

  def get_user_appointment(id)
    if patient_url?
      @target_user.appointments.find(id)
    elsif doctor_url?
      @target_user.inverse_appointments.find(id)
    end
  end

  def set_target_user
    if patient_url?
      @target_user = User.patient.find(params[:user_id])
    elsif doctor_url?
      @target_user = User.doctor.find(params[:doctor_id])
    end
  end
end
