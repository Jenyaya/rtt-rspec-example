
class NotConfiguredSenderEmailError < StandardError
  def message
    'Service is not responding or not configured. Check email config.'
  end
end

class ProjectsExist < StandardError
  def message
    'User still have few projects, when expected that tests should delete all of them.'
  end
end
