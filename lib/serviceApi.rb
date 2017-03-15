class ServiceApi

  attr_accessor :url, :cookie, :token, :hash

  def initialize(hash = {:url => $environment['host'], :path => ''})
   @url = "#{hash[:url]}#{hash[:path]}"
   @cookie = hash[:cookie] if hash.key?(:cookie)
   @Authorization = hash[:Authorization] if hash.key?(:Authorization)
  end

end
