class Player
  attr_reader :name, :sign
  def initialize(name, sign)
    @name = name
    @sign = sign
    puts "Welcome #{@name}, you will be putting #{@sign}'s on the board!"
  end

  def win_cond
    win = [
          ]
  end
end

class Board
  def initialize()
    @squares = {
      top_left:  " ", top_middle: " ", top_right: " ",
      middle_left: " ", middle_middle: " ", middle_right: " ",
      bottom_left: " ", bottom_middle: " ", bottom_right: " "  
    }
  end

  def display()
    return " " + @squares[:top_left] +  " | " + @squares[:top_middle] + " | " + @squares[:top_right] + " \n" +
           "~~~ ~~~ ~~~ \n" +
           " " + @squares[:middle_left] +  " | " + @squares[:middle_middle] + " | " + @squares[:middle_right] + " \n" +
           "~~~ ~~~ ~~~ \n" +
           " " + @squares[:bottom_left] +  " | " + @squares[:bottom_middle] + " | " + @squares[:bottom_right] + " \n" 
  end 

  def untaken_squares
    empty = []
    @squares.each { |x,y| empty << x if y == " " }
    return empty
  end

  def assign_square(move, name)
    @squares[move] = name
  end

  def player_squares(sign)
    player_squares = []
    @squares.each { |x,y| player_squares << x if y == sign } 
    return player_squares 
  end
end

class Game
  def initialize(name_one, sign_one, name_two, sign_two)
    @board = Board.new
    @player1 = Player.new(name_one, sign_one)
    @player2 = Player.new(name_two, sign_two)
    @ongoing = true
  end

  def win
    if @board.player_squares(sign) == 
      #horizontal
      [:top_left, :top_middle, :top_right] ||  [:middle_left, :middle_middle, :middle_right] || [:bottom_left, :bottom_middle, :bottom_right] ||
      #vertical
      [:top_left, :middle_left, :bottom_left] || [:top_middle, :middle_middle, :bottom_middle] || [:top_right, :middle_right, :bottom_right] ||
      #diagonal
      [:top_left, :middle_middle, :bottom_right] || [:top_right, :middle_middle, :bottom_left]
  end
 
  def play
     puts "Alright setting up a new game one moment please."
     puts "Here is your new board!"
     puts  @board.display()
     #loop
     while @ongoing
       puts "What would you like to do: (View Board/Make Move)"
       input = gets.chomp
       if input == "View Board"
         puts @board.display()
       elsif input == "Make Move"
           puts "Here is a list of squares that have not been taken"
           puts @board.untaken_squares()
           puts "Please select one of the empty squares to make a move"
           move = gets.chomp
           if @board.untaken_squares().include? move.to_sym
               @board.assign_square(move.to_sym, @player1.sign)
           else
              puts "Sorry that square might be taken or you entered the name incorrectly, please try again"
           end
       end
     end      
  end
end

puts "What is player's one name?"
pname1 = gets.chomp
puts "What is the player's one sign? X or O?"
psign1 = gets.chomp

puts "What is player's two  name?"
pname2 = gets.chomp
puts "What is the player's two sign? X or O?"
psign2 = gets.chomp

game = Game.new(pname1, psign1, pname2, psign2)
game.play
