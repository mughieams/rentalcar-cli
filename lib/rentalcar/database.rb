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
  
      def read(table)
        query "SELECT * FROM #{table}"
      end
  
      def insert(table, _data = {})
        _data.delete_if { |_key, value| value.to_s.strip == '' }
        query "INSERT INTO #{table} (#{_data.keys.map(&:to_s).join(',')})
          VALUES (#{_data.values.map { |value| "'#{value}'" }.join(',')})"
      end
  
      def update(table, reg_number, _data = {})
        _data.delete_if { |_key, value| value.to_s.strip == '' }
        query "UPDATE #{table} SET
            #{_data.map { |key, value| "#{key}='#{value}'" }.join(',')}
         WHERE reg_number like '#{reg_number}'"
      end
  
      def find(table, param, value)
        query "SELECT * FROM #{table}
        WHERE #{param} like '#{value}'"
      end
    end
  end
  