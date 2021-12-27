module AppointmentHelper
    def get_user_appointment(id)
        if patient_url?
          @target_user.appointments.find(id)
        elsif doctor_url?
          @target_user.inverse_appointments.find(id)
        end
      end

      def doctor_url?
        regex = %r{/api/v1/doctors}
        regex.match(request.fullpath)
      end
    
      def patient_url?
        regex = %r{/api/v1/users}
        regex.match(request.fullpath)
      end
end