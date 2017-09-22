module WebSockets

  class Client
    attr_reader :url, :consumer_type, :protocols, :options, :messages

    def initialize(url, consumer_type='auth-token', protocols = nil, options = {})
      @url = url
      @protocols = protocols
      @options = options
    end

    def self.set_ws_connection(ws_messages, examples_amount, url, protocols = nil, options = {}, query_params = nil)
      # ws_messages is an instance of WSMessages class to add into class variable messages pool events

        url = url + '&' + query_params  if query_params

      EM.run do

        ws = Faye::WebSocket::Client.new(url, protocols, options)

        ws.on :open do |event|
          $logger.debug event
        end

        ws.on :error do |event|
          $logger.debug event.code, event.reason
          ws.close
          EM.stop
        end

        ws.on :message do |msg, type|
          ws_messages.add_to_pool msg.data
          $logger.debug 'WS event: ' + msg.data
        end

        ws.on :close do |event|
          $logger.debug [:close, event.code, event.reason]
          ws.close
        end

        EM.add_timer(examples_amount*1+45) { EM.stop }

      end
    end
 end
end
