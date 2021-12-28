module DoctorHelper
  def reject_attempt_to_create_user
    return unless doctor_url? && (!user_params[:is_doctor] || !user_params[:office_address])

    render json: { error: "Can't create user from a /#{params[:controller]} endpoint" },
           status: :forbidden
  end
end
