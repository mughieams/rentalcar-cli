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

    def rent(reg_number, renter, date)
      car = Parser.new.parse(reg_number, nil, renter, date)
      car.mark_rent
      @@rental.update('cars', reg_number, car.to_hash)
      puts '  ' + Rainbow("Reserved #{reg_number} to #{renter} on #{date}").green.bright
    rescue PG::Error
        puts '  ' + Rainbow("Already reserved").red.bright
    end

    def status(date)
      cars = @@rental.read('cars')
      unless cars.nil?
        puts '  ' + Rainbow("Reg Number\tColor\tStatus\t\tCustomer").green.bright
      end
      cars.each do |row|
        next unless row['date']

        if Date.parse(row['date']) < Date.parse(date)
          row['status'] = 'free'
          row['renter'] = nil
        end
        puts '  ' + format(Rainbow("%s\t%s\t%s\t%s").blue.bright, row['reg_number'], row['color'], row['status'], row['renter'])
      end
    end

    def search_car_by_reg_number(reg_number)
      cars = @@rental.find('cars', 'reg_number', reg_number)
      puts '  ' + Rainbow("Reg Number\tColor").green.bright unless cars.nil?
      cars.each do |row|
        puts format('  ' + Rainbow("%s\t%s").blue.bright, row['reg_number'], row['color'])
      end
    end

    def search_car_by_color(color)
      cars = @@rental.find('cars', 'color', color)
      puts '  ' + Rainbow("Reg Number\tColor").green.bright unless cars.nil?
      cars.each do |row|
        puts format('  ' + Rainbow("%s\t%s").blue.bright, row['reg_number'], row['color'])
      end
    end
  end
  end
