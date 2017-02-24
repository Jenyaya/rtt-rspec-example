require 'init'

describe Car do

  it 'has method brand' do
    expect(Car.new).to respond_to(:brand)
  end

end
