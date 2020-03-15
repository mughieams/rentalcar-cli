# frozen_string_literal: true

module RentalCar
    class Car
      attr_accessor :reg_number, :color, :status, :renter, :date
  
      def initialize
        @reg_number = []
        @color = []
        @status = 'free'
        @renter = []
        @date = []
      end
  
      def valid?
        !@reg_number.nil? && @reg_number != '' && !@color.nil? && @color != ''
      end
  
      def mark_rent
        @status = 'rentered'
      end
  
      def load_from_hash(hash)
        @reg_number = hash.fetch(:reg_number, nil) || hash.fetch('reg_number')
        @color = hash.fetch(:color, nil) || hash.fetch('color')
        @status = hash.fetch(:status, nil) || hash.fetch('status')
        @renter = hash.fetch(:renter, nil) || hash.fetch('renter')
        @renter = hash.fetch(:date, nil) || hash.fetch('date')
      end
  
      def to_hash
        {
          reg_number: reg_number,
          color: color,
          status: status,
          renter: renter,
          date: date
        }
      end
    end
  end
  