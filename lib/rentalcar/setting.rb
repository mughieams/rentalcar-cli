# frozen_string_literal: true

module RentalCar
    class Setting
      attr_reader :env, :file_config
  
      def initialize
        @env = configuration('../../config/_config.yml')
      end
  
      def configuration(file_name)
        @file_config = YAML.load_file(File.join(__dir__, file_name))
      end
    end
  end
  