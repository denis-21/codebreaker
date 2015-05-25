module Codebreaker
  class Results

    FILE_RESULTS = 'file_results.txt'

    class << self

      def get_info player = {}
        "Player: #{player[:name]} , attempts: #{player[:user_attempts]}, all_attempts: #{player[:all_attempts]}"
      end

      def load
        data_file = String.new
        File.readlines(FILE_RESULTS).each do |line|
          data_file << line
        end
        data_file
      end

      def set data
        return false unless File.exist? FILE_RESULTS
        data_file = load
        File.open FILE_RESULTS, 'w' do |f|
          f.puts data_file << data
        end
      end

      def save_result (user_name,number_attempts,all_attempts)
          info = self.get_info name: user_name, user_attempts: number_attempts,all_attempts: all_attempts
          self.set info
      end

    end
  end
end