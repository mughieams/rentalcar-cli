# frozen_string_literal: true

RSpec.describe 'Parser' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  describe 'passes to date.parse' do
    it 'if has a value' do
      expect(RentalCar::Parser.new.date('2020-03-18')).to eq(Date.parse('2020-03-18'))
    end

    it 'if the value is nil' do
      expect(RentalCar::Parser.new.date(nil)).to be_nil
    end
  end

  describe 'passes to item.parse' do
    it 'if has a value' do
      expect(RentalCar::Parser.new.item('BB-4564')).to eq('BB-4564')
    end

    it 'if the value is nil' do
      expect(RentalCar::Parser.new.item(nil)).to be_nil
    end
  end

  it 'can generate a car' do
    car = RentalCar::Parser.new.parse('BB-4564', 'white', 'Budi', '2020-03-18')
    expect(car.class).to eq(RentalCar::Car)
    expect(car.reg_number).to eq('BB-4564')
    expect(car.color).to eq('white')
    expect(car.renter).to eq('Budi')
    expect(car.date).to eq(Date.parse('2020-03-18'))
  end
end
