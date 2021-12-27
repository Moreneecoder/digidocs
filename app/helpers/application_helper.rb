module ApplicationHelper
  def url
    request.fullpath
  end

  def doctor_url?
    regex = %r{/api/v1/doctors}
    regex.match(url)
  end

  def patient_url?
    regex = %r{/api/v1/users}
    regex.match(url)
  end
end
