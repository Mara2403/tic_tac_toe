class Game
end

# Player class represents a player in a Tic Tac Toe game.
# It has attributes for the player's name and chosen symbol.
#
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
    puts 'Please, choose a symbol:'
    gets.chomp
  end
end

puts 'Welcome to the simple Tic Tac Toe game!'
puts 'Player 1:'
player1 = Player.new
puts "Hello #{player1.name}, you will use #{player1.symbol}"
puts 'Player 2:'
player2 = Player.new(player1.symbol == 'x' ? 'o' : 'x')
puts "Hello #{player2.name}, you will use #{player2.symbol}"
