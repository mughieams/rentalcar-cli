# frozen_string_literal: true

module RentalCar
    class Parser
      def parse(reg_number = nil, color = nil, renter = nil, date = nil)
        car = Car.new
        car.reg_number = item(reg_number)
        car.color = item(color)
        car.renter = item(renter)
        car.date = date(date)
        car
      end
  
      def item(value)
        value.nil? ? nil : value
      end
  
      def date(value)
        value.nil? ? nil : value.to_date
      end
    end
  end
  