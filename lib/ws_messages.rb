class WSMessages

  def initialize
    @@pool = {}
    @ws_messages_events = {} # list of possible events
    @ws_subjects = {} # list of possible event subjects
  end

  def self.clean_pool
    @@pool = {}
  end

  def get_pool
    @@pool
  end

  def get_events_pool
    @@pool['events']
  end

  def add_to_pool(data)

    message = JSON.parse data

    if message['data']['userId']
      @@pool[message['data']['userId']] ||= []
      @@pool[message['data']['userId']] << message

    else
      @@pool['bucket'] ||= []
      @@pool['bucket'] << message
    end

    @@pool['events'] ||= []

    if message['data']['event']
      @@pool['events'] << message['data']['event']
    else
      @@pool['events'] << message['subject']
    end

    def pool_initialized?(messages_pool, event, user_id = false, default_iterations = 10, sleep_time = 0.1)
      # check that at least one message is in the pool
      # call to get_pool[user_id]
    end

    def wait_ws_event(messages_pool, event, default_iterations = 10, sleep_time = 0.1)
      # messages_pool is an instance of WSMessages class to support dynamically changed pool of ws messages during wait
      # call to pool_initialized
      # then call to get_events_pool(event)
    end

    def wait_ws_event_by_user(user_id, messages_pool, event, default_iterations = 10, sleep_time = 0.1)
      # messages_pool is an instance of WSMessages class to support dynamically changed pool of ws messages during wait
      # wait pool_initialized?
      # then wait for expected message
      # or raise WSMessageNotRecievedError, "WS message '#{event}' was not received in #{default_iterations*sleep_time} seconds!", caller
    end

  end

end

class WSMessageNotRecievedError < StandardError;
end
