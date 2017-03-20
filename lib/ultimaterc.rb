require 'rest-client'

class UltimateRestClient
  include RestClient

  def self.verify_certificate_flag
    $environment['ssl_certificate_verification']
  end

  ERRORS = [RestClient::ResourceNotFound, RestClient::BadRequest, RestClient::Unauthorized, RestClient::Conflict,
            RestClient::Conflict, RestClient::Forbidden, Net::HTTPInternalServerError, RestClient::InternalServerError,
            RestClient::GatewayTimeout, RestClient::Unauthorized, Net::HTTPGatewayTimeOut, RestClient::PaymentRequired, Net::HTTPBadRequest]


  def self.call_to_service(method, url, data, params)
    start_time = Time.now
    RestClient::Request.execute(:method => method, :url => url, :headers => params, :payload => data, :verify_ssl => verify_certificate_flag) do |response, request, result|
      puts method.upcase, url, params.to_s, data
      # $profiler.debug sprintf(PROFILER_TEMPLATE, calc_time_spent(start_time, Time.now).to_s, method.upcase, url, params.to_s, data)
      return response, request, result
    end

  end

  def self.call_from_tests(method, url, data, params = {})

    params[:content_type] = 'application/json' unless params[:content_type]
    data.class == Hash ? data=data.to_json : data
    data.class == Array ? data=data.to_json : data

    begin
      response, request, result = call_to_service(method, url, data, params)
    rescue *ERRORS => e
      # $logger.info "[#{result.code}] - UltimateRestClient: failed with #{e}, RESULT #{method.upcase}: " + result.to_s
      puts "[#{result.code}] - UltimateRestClient: failed with #{e}, RESULT #{method.upcase}: " + result.to_s
      return response, result
    else
      if response.empty?
        puts "[#{response.code}] UltimateRestClient: EMPTY RESULT for " + method.to_s + ': ' + result.to_s
        return result
      else
        puts "[#{response.code}] UltimateRestClient: RESPONSE #{method.upcase}: " + response.to_s
        # $logger.info 'Response class in #call_from_tests ' + response.class.name
        # $logger.info 'Response result in #call_from_tests ' +  result.class.name
        return response
      end


    end

  end

end