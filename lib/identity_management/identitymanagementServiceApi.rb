class IdentityManagementServiceApi < ServiceApi

  def initialize(hash={
                      :url => $environment['host'],
                      :path => $environment_common['identity_management_service_path']
                      })
    super(hash)
  end


  def create_identity()
  end

  def delete_identity
  end

  def generate_identity_token
  end

  def set_identity_permissions
  end

  def get_identity_permissions
  end

end
