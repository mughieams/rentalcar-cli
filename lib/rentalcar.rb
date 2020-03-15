# frozen_string_literal: true

require 'yaml'
require 'pg'

require 'rentalcar/version'
require 'rentalcar/setting'
require 'rentalcar/database'
require 'rentalcar/car'
require 'rentalcar/parser'

module RentalCar
  class Error < StandardError; end
  # Your code goes here...
end
