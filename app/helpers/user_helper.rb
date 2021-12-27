module UserHelper
    def reject_attempt_to_create_doctor
      return unless patient_url? && (params[:is_doctor] || params[:office_address])
    
      render json: { error: "Can't create doctor from a /#{params[:controller]} endpoint" },
            status: :forbidden
    end
end