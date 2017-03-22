require 'rest-client'

response = nil
describe 'Bundle Example' do

  subject { RestClient.get('https://httpbin.org/get', headers={}) }

  it { is_expected.to be_a String }
  it { is_expected.to be_a RestClient::Response }

  #Response objects are now a subclass of String rather than a String
  it '1.8.0' do
    expect(subject.body).to be_a String
  end

  it '2.0.0' do
    expect(subject.body).to be_a RestClient::Response
  end

end