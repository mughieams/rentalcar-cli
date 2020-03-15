# frozen_string_literal: true

module RentalCar
  class App
    @@rental = Database.new

    def create_rental(name)
      @@rental.drop_table(name)
      @@rental.create_table(name)
      puts "  #{Rainbow('Rental').green.bright} #{Rainbow(name).blue.bright} #{Rainbow('created').green.bright}"
    end

    def create_car(reg_number, color)
      car = Parser.new.parse(reg_number, color)
      if car.valid?
        @@rental.insert('cars', car.to_hash)
        puts "  #{Rainbow('Car').green.bright} #{Rainbow("#{reg_number} #{color}").blue.bright}  #{Rainbow('saved').blue.bright}"
      else
        puts '  ' + Rainbow('Car not saved, it needs a registration number and color..').red.bright
      end
    rescue PG::Error
      puts '  ' + Rainbow("Car can't save, registration number already exist").red.bright
    end
  end
  end
