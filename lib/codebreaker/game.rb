require_relative 'version'
require_relative 'results'

module Codebreaker
  class Game
    attr_reader  :secret_code, :hint
    attr_accessor :attempt

    def initialize
      @secret_code = 4.times.map { rand(1..6) }.join
      @hint = true
      @attempt = 5
    end

    def compare user_code
      return 'You entered is not a number, or a length of less than 4 or greater is present number 6' unless user_code.match(/^[1-6]{4}/)
      @attempt -= 1
      tmp_code = @secret_code.clone
      tmp_user_code = user_code.clone
      msg = String.new
      tmp_val = String.new
      @secret_code.each_char.each_with_index do |numbr ,index|
        if @secret_code[index]==user_code[index]
          msg << '+'
          tmp_val << @secret_code[index]
          tmp_code.slice! @secret_code[index]
          tmp_user_code.slice! @secret_code[index]
        end

      end

      tmp_user_code.each_char do |val|
        if tmp_code.include? val
          tmp_code.slice! tmp_code[tmp_code.index val]
          msg << '-'
        end
      end
      
      if @attempt ==0 && msg != '++++'
        return 'Game over'
        
      msg
    end

    def get_hint
      @hint = false
      result = '****'
      val = rand(@secret_code.size)
      result[val] = @secret_code[val]
      result
    end

  end
end
