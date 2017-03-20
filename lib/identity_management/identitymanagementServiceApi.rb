class UserManagementServiceApi < ServiceApi

  def initialize(init={
      :url => $environment['host'],
      :path => $environment_common['user_management_service_path']
  })
    super(init)
  end

  # @token [String] Authorization token
  def get_users(token)
    url = sprintf('%s%s', self.url, '/users')
    UltimateRestClient.call_from_tests :get, url, nil, authorization_param(token)
  end

  # @param [Hash] data - info about user
  # @token [String] Authorization token
  def create_user(data, token)
    url = sprintf('%s%s', self.url, '/users')
    UltimateRestClient.call_from_tests :post, url, data, authorization_param(token)
  end

  # @param [String] user_id valid UUID v.4 id of the user
  # @token [String] Authorization token
  def delete_user(user_id)
    url = sprintf('%s%s', self.url, '/users/', user_id)
    UltimateRestClient.call_from_tests :delete, url, nil, authorization_param(token)
  end

  def generate_user_token(user_id)
    url = sprintf('%s%s', self.url, '/tokens', user_id)
    UltimateRestClient.call_from_tests :post, url, {:token => base64(user_id)}
  end

  def set_user_permissions(user_id, data, token)
    url = sprintf('%s/%s/%s/%s', self.url, 'users', user_id, 'permissions')
    UltimateRestClient.call_from_tests :post, url, data, authorization_param(token)
  end

  def get_user_permissions(user_id, token)
    url = sprintf('%s/%s/%s/%s', self.url, 'users', user_id, 'permissions')
    UltimateRestClient.call_from_tests :get, url, nil, authorization_param(token)
  end

end
