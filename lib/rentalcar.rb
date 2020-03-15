# frozen_string_literal: true

require 'yaml'
require 'pg'
require 'rainbow'

require 'rentalcar/version'
require 'rentalcar/setting'
require 'rentalcar/database'
require 'rentalcar/car'
require 'rentalcar/parser'
require 'rentalcar/app'

module RentalCar
  class Error < StandardError; end

  class Binary
    def initialize
      @app = RentalCar::App.new
    end

    def route_input(input)
      case input.split[0]
      when 'create_rental'
        @app.create_rental(input.split[1])
      when 'create_car'
        @app.create_car(input.split[1], input.split[2])
      else
        help
      end
    end

    def help
      puts "\n"
      puts "  $ rentalcar #{Rainbow('[command]').blue.bright} - a simple command line rental car simulation program\n\n"
      puts "               #{Rainbow('create_rental').blue.bright} #{Rainbow('[name]').green.bright}                      => Create a new rental car"
      puts "                  #{Rainbow('create_car').blue.bright} #{Rainbow('[reg-number] [color]').green.bright}        => Adds a new car to rental"
      puts "                        #{Rainbow('rent').blue.bright} #{Rainbow('[reg-number] [name] [date]').green.bright}  => Rents a car from rental"
      puts "                      #{Rainbow('status').blue.bright} #{Rainbow('[date]').green.bright}                      => Show list of available cars on that date"
      puts "    #{Rainbow('search_car_by_reg_number').blue.bright} #{Rainbow('[reg-number]').green.bright}                => Search for detail data car by registration number"
      puts "         #{Rainbow('search_car_by_color').blue.bright} #{Rainbow('[color]').green.bright}                     => Search for detail data car by color\n\n"
    end
  end
end
