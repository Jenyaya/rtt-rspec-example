require 'init'

describe Car do


  let (:car) { Car.new }

  it 'has method brand' do
    expect(Car.new).to respond_to(:brand)
  end

  it :brand= do
    expect(Car.new).to respond_to(:brand=)
  end

  it 'car is Toyota' do
    expect(car.is_brand?('toyota')).to be true
  end

  it 'car is not Honda' do
    expect(car.is_brand?('honda')).to be false
  end

end
