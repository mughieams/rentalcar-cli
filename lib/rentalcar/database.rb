# frozen_string_literal: true

module RentalCar
    class Database
      attr_accessor :DB
  
      def initialize
        config = Setting.new
        @DB = PG.connect(
          dbname: config.env['db_name'],
          user: config.env['db_user'],
          password: config.env['db_pass']
        )
      end
  
      def query(query)
        @DB.exec query
      end
  
      def drop_table(table)
        query "DROP TABLE IF EXISTS #{table}"
      end
  
      def create_table(table)
        query "CREATE TABLE #{table} (
            reg_number VARCHAR(20) PRIMARY KEY,
            color VARCHAR(10),
            status VARCHAR(8),
            renter VARCHAR(50),
            date DATE
         )"
      end
    end
  end
  