# frozen_string_literal: true

module RentalCar
  class App
    @@rental = Database.new

    def create_rental(name)
      @@rental.drop_table(name)
      @@rental.create_table(name)
      puts "  #{Rainbow('Rental').green.bright} #{Rainbow(name).blue.bright} #{Rainbow('created').green.bright}"
    end
  end
  end
