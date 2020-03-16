# frozen_string_literal: true

RSpec.describe 'Car' do
  before do
    @car = RentalCar::Car.new
  end

  after do
    # Do nothing
  end

  it 'has value if load from hash' do
    @car.load_from_hash(
      {
        'reg_number': 'BB-4564',
        'color': 'white',
        'status': 'rentered',
        'renter': 'Budi',
        'date': '2020-03-18'
      }
    )
    expect(@car.reg_number).to eq('BB-4564')
    expect(@car.color).to eq('white')
    expect(@car.status).to eq('rentered')
    expect(@car.renter).to eq('Budi')
    expect(@car.date).to eq('2020-03-18')
  end
end
