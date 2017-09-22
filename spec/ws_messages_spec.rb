require './lib/init'

ws_messages = WSMessages.new
ws_messages_events = ws_messages.ws_messages_events
ws_threads = []
examples_amount = nil

describe 'WS notifications in chat room' do
  include EM::SpecHelper

  before :all do
    examples_amount = self.class.examples.size
  end

  after :all do
    # close therads and stop EM
    ws_threads.each { |t| t.terminate }
    WSMessages.clean_pool
  end

  after :each do
    sleep 1 # can be ommited by calling wait_ws_event methods
  end

  it 'connect by WS by user A' do
    ws_threads << Thread.new { WebSockets::Client.set_ws_connection(ws_messages,
                                                                    examples_amount,
                                                                    ws_notifications_url,
                                                                    'ws',
                                                                    {:headers => {'cookie' => 'accessToken='+ user_A[:token_id]}}
    ) }
  end

  it 'connect by WS by user B' do
    ws_threads << Thread.new { WebSockets::Client.set_ws_connection(ws_messages,
                                                                    examples_amount,
                                                                    ws_notifications_url,
                                                                    'ws',
                                                                    {:headers => {'cookie' => 'accessToken='+ user_B[:token_id]}}
    ) }
  end


  it 'notification_update_msg' do
    ws_messages.wait_ws_event(ws_messages, ws_messages_events[:notification_update_msg], 10, 0.5)
    expect(ws_messages.get_pool['bucket'].last['subject']).to eq ws_messages_events[:notification_update_msg]
  end

  it 'notification_update_msg' do
    ws_messages.wait_ws_event(ws_messages, ws_messages_events[:notification_update_msg], 10, 0.5)
    expect(ws_messages.get_pool['bucket'].last['subject']).to eq ws_messages_events[:notification_update_msg]
  end

  it 'user A sends text message' do
  end

  it ws_messages_events[:message_created_msg] do
    ws_messages.wait_ws_event_by_context(user_A[:identityId], ws_messages, ws_messages_events[:message_created_msg], 7, 0.5)
  end

  it ws_messages_events[:message_created_msg] do
    ws_messages.wait_ws_event_by_context(user_B[:identityId], ws_messages, ws_messages_events[:message_created_msg], 7, 0.5)
  end

  it 'user A edits text message' do
  end

  it ws_messages_events[:message_updated_msg] do
    ws_messages.wait_ws_event_by_context(user_A[:room_id], ws_messages, ws_messages_events[:message_updated_msg], 7, 0.5)
  end

  it ws_messages_events[:message_updated_msg] do
    ws_messages.wait_ws_event_by_context(user_B[:identityId], ws_messages, ws_messages_events[:message_updated_msg], 7, 0.5)
  end

  it 'user A archived chat room' do
    # user A archived chat room. Room moved to Archived tab for that user. User B still has the room in Active list.
  end

  it ws_messages_events[:context_archived_msg] do
    ws_messages.wait_ws_event_by_context(user_A[:identityId], ws_messages, ws_messages_events[:context_archived_msg], 7, 0.5)
    context_archived_msg = ws_messages.get_pool[user_A[:identityId]].last
    expect(context_archived_msg['data']['message']['context']['archived']).to be_true
  end

  it ws_messages_events[:context_archived_msg] do
    expect { ws_messages.wait_ws_event_by_context(user_B[:identityId], ws_messages, ws_messages_events[:context_archived_msg], 1, 0.5) }.to raise_error(WSMessageNotRecievedError)
  end

end
