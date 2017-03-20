describe 'Test IM REST API' do

  users_api = UserManagementServiceApi.new
  user = UserManagementData.new.data

  it 'generate_user_token' do
    response = users_api.generate_user_token user[:id]

    expect(response.code).to eq 201
    user[:token] = users_api.parse_response(response)[:token]
  end
  it 'create_user' do
    response = users_api.create_user(user, user[:token])
    expect(response.code).to eq 201

    created_user = users_api.parse_response response

    expect(created_user[:first_name]).to eq user[:first_name]
    expect(created_user[:last_name]).to eq user[:last_name]
    expect(created_user[:address][:state]).to eq user[:address][:state]
  end


end
