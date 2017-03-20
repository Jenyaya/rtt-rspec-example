class ServiceApi

  attr_accessor :url, :cookie, :token, :hash

  def initialize(init = {:url => $environment['host'], :path => ''})
    @url = "#{init[:url]}#{init[:path]}"
    @cookie = init[:cookie] if init.key?(:cookie)
    @Authorization = init[:Authorization] if init.key?(:Authorization)
  end

  def authorization_param(token)
    token.include?('accessToken') ?
        {:cookies => {:accessToken => token.sub('accessToken=', '')}} :
        {:Authorization => 'Bearer ' + token}
  end

  # --- response parsing methods --- #

  def parse_response(response, symbolize = true)
    JSON.parse(response, :symbolize_names => symbolize)
  end


end
