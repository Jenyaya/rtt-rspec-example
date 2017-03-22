require 'init'

describe Car do
  let (:car) { Car.new }

  context 'pending' do
    pending 'pending context but created new example'
    it 'has method #brand' do
      expect(Car.new).to respond_to(:brand_new?)
    end

    it :brand= do
      expect(Car.new).to respond_to(:brand=)
    end
  end

  xcontext 'skipped' do
    it 'car is Toyota' do
      expect(car.is_brand?('toyota')).to be true
    end

    it 'car is not Honda' do
      it 'Pending example with a message'
      expect(car.is_brand?('honda')).to be false
    end
  end
end
