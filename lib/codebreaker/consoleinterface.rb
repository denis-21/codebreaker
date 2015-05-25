require_relative 'version'
require_relative 'game'
require_relative 'results'

module Codebreaker

  class ConsoleInterface

    def initialize
      @game = Game.new
    end

    def user_greet
      puts "Welcome to the game!"
      puts "To exit, type \"exit\""
      puts "You have to guess the secret number of 4 numbers from 1 to 6"
      puts
      puts "Enter the number of attempts for which you could recognize the number."

      user_attemt = gets.chomp!
      if user_attemt.match(/^[1-9]/)
         @game.attempt = user_attemt.to_i
      else
        puts "You entered is not a number"
      end

      puts "You have to guess the secret number of 4 numbers from 1 to 6 for #{@game.attempt} attempts."
      puts "If you want to open a single number, enter \"help\" "
    end

    def start

      user_greet

      (1..@game.attempt).each do |val|
        user_comand = gets.chomp!

        if user_comand =='exit'
          exit
        end

        if user_comand == 'help' && @game.hint
          puts @game.get_hint
        else
          result = @game.compare user_comand

          if result == '++++'
            puts 'You won!!!'
            puts 'Do you want to save the result? If so, please enter your name. If not, enter \"exit\"'
            user_name = gets
            if user_name == 'exit'
              exit
            else
              Results.save_result(user_name.chomp!,val, @game.attempt)
              restart
            end
          elsif val == @game.attempt
            puts "#{val} attempt:" + result
            puts 'All attempts have ended'
            puts 'Game over'
            restart
          end
          puts "#{val} attempt:" + result
        end
      end
    end

    def restart
      puts 'Would you like start a new game?If so, please enter \"y\"'
      user_comand = gets
      if user_comand.chomp! == 'y'
        puts '--------------------------------------'
        puts '-----------Restart Game----------------'
        puts '--------------------------------------'
        puts
        ConsoleInterface.new.start
      else
        exit
      end
    end

  end

end
