# frozen_string_literal: true

# Display board
class Board
  attr_reader :cells

  WIN_COMBINATIONS = [[1, 2, 3], [4, 5, 6],[7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

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

  def update_board(number, symbol)
    @cells[number - 1] = symbol
  end

  def full_board?
    cells.all? { |cell| cell.is_a?(String) }
  end

  def valid_move?(number)
    number.between?(1, 9) && cells[number - 1].is_a?(Integer)
  end

  def check_for_winner
    WIN_COMBINATIONS.each do |combination|
      positions = combination.map { |position| cells[position - 1] }
      if positions.uniq.length == 1
        return positions[0] # Returns the winning symbol
      end
    end
    nil # Returns nil if there is no winner
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

      return chosen_symbol if valid_symbols.include?(chosen_symbol)

      puts 'Invalid choice. Please choose either x or o.'
    end
  end
end

# Gameplay
class Game
  def initialize
    puts "Welcome to the simple Tic Tac Toe game!\n\n"

    puts 'Player 1:'
    player1 = Player.new
    puts "Hello #{player1.name}, you will use #{player1.symbol}\n\n"

    puts 'Player 2:'
    player2 = Player.new(player1.symbol == 'x' ? 'o' : 'x')
    puts "Hello #{player2.name}, you will use #{player2.symbol}"

    @current_player = player1
    @other_player = player2

    @board = Board.new
    @board.show_board
  end

  def play
    loop do
      make_move
      @board.show_board

      if @board.check_for_winner
        puts "#{@current_player.name} wins! Congratulations!"
        play_again?
        break
      elsif @board.full_board?
        puts "It's a draw"
        play_again?
        break
      end

      switch_players
    end
  end

  private

  def make_move
    puts "#{@current_player.name} choose one number where you want to place #{@current_player.symbol}"
    user_cell_choice = gets.chomp.to_i

    until @board.valid_move?(user_cell_choice)
      puts 'Invalid choice. Please choose available space'
      user_cell_choice = gets.chomp.to_i
    end

    @board.update_board(user_cell_choice, @current_player.symbol)
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def play_again?
    puts 'Do you want to play again? [Y/n]'
    user_input = gets.chomp.downcase

    case user_input
    when 'y'
      puts "Great! Let's begin."
      @board = Board.new
      @board.show_board
      play
      true
    when 'n'
      puts 'Alright, thanks for playing!'
      false
    else
      puts "Invalid input. Please enter 'y' or 'n'."
      play_again?
    end
  end
end

game = Game.new
game.play
