# frozen_string_literal: true

# Display board
class Board
  attr_reader :cells

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_board
    puts <<-HEREDOC

      #{cells[0]} | #{cells[1]} | #{cells[2]}
      ---+---+---
      #{cells[3]} | #{cells[4]} | #{cells[5]}
      ---+---+---
      #{cells[6]} | #{cells[7]} | #{cells[8]}

    HEREDOC
  end
end

# Player's name and chosen symbol
class Player
  attr_accessor :name, :symbol

  def initialize(symbol = nil)
    @name = ask_for_name
    @symbol = symbol.nil? ? choose_symbol : symbol
  end

  def ask_for_name
    puts "What's your name"
    gets.chomp
  end

  def choose_symbol
    # same as  valid_symbols = ['x', 'o']
    valid_symbols = %w[x o]
    puts 'Please, choose a symbol, x or o?'
    loop do
      chosen_symbol = gets.chomp.downcase

      if valid_symbols.include?(chosen_symbol)
        return chosen_symbol
      else
        puts 'Invalid choice. Please choose either x or o.'
      end
    end
  end
end

# Gameplay
class Game
  puts "Welcome to the simple Tic Tac Toe game!\n\n"
  puts 'Player 1:'
  player1 = Player.new
  puts "Hello #{player1.name}, you will use #{player1.symbol}\n\n"
  puts 'Player 2:'
  player2 = Player.new(player1.symbol == 'x' ? 'o' : 'x')
  puts "Hello #{player2.name}, you will use #{player2.symbol}"

  new_board = Board.new
  new_board.show_board
end
