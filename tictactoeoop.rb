#two major approaches to building an oop.
#You look at your procedural program and note where you're passing around a lot of objects.
#We're passing "board" alot around the code and it is of Hash class, which may be a sign that you need a more complicated structure.
#So you can extract these variables into a class.

# Another way is to write out a description of the program and then extract nouns from the descriptions groupt common verbs into nouns.
# This is difficult to do because of how you model the program in your mind. We all develop our own mental model of the programs depending on how we think.
#When you look at code, you're really trying to get into the mindset of the programmer, to see how they're processing the information.

#What is a Tic Tac Toe Game?

#It's a board game with two players. We start with an empty 3 X 3 board. One player is 'X', the other player is 'O'.
#The 'X' player goes first. The two players alternate to mark an empty square. Alternate turns until a player gets
#three 3 squares in a row. If all squares are marked and nobody won, then it's a tie.

##Let's take the major nouns(classes) out of this and then list verbs under(behaviors) each noun:
# - board (we can mark states of the board)
#	- all squares marked?
# 	- find all empty squares
#   - WHAT IS A BOARD AWARE OF?
# 		- s
# - player (You don't need player 2 because it will have same behavior)
#	  - WHAT IS A BOARD AWARE OF?
#		 -marker
# 	 -name
# - square
#   -occupied?
#   -position (if you think the square should be aware of it's position, then it intimately ties to the board) We're going to do without this.
#   - mark(marker)




# game engine
# - marks the player
#   The game engine is going to be the same as the algorithm we wrote for the procedural version.
#    It will player

 #draw a board

# assign player1 to "X"
# assign computer to "O"

# loop until a winner or all squares are taken
#   player picks an empty square
#   checkwin
#   computer picks an empty square
#   checkwin

# if there is a winner 
#   show the winner
# else 
#   it's a tie
# end



class Board
  WINNING_LINES =   [ [1,2,3],
                      [4,5,6],
                      [7,8,9],
                      [1,4,7], 
                      [2,5,8],
                      [3,6,9],
                      [1,5,9],
                      [3,5,7] ]


  def intitialize
    @data={}
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end

  def draw
    system 'cls'
    puts "_#{@data[1]}_|_#{@data[2]}_|_#{@data[3]}_"
    puts "_#{@data[4]}_|_#{@data[5]}_|_#{@data[6]}_"
    puts " #{@data[7]} | #{@data[8]} | #{@data[9]} "
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def empty_squares
    @data.select {|_, square| square.empty?}.values #the value here is a "square" object, so we changed the name to make easier to read
                                                          #we also added attr_accessor to the square object so that we can use a "getter" method to
                                                          #get us a value for us to us for this select method.
                                                          #1) Also notice that we put a "_" for the Key variable, becuase it is Ruby Convention to put 
                                                          #an underscore symbol when the Key variable is irrelavent for the purpose of this function.
                                                          #2) Also this select method returns a hash. We appended ".values" to the end of it to return
                                                          #an array of the values.
  end

  def empty_positions
    @data.select{|_, square| square.empty?}.keys
  end

  def mark_square(position, marker)
    @data[position].mark(marker) #here we're calling a square object and asking it to mark itself. So we need to design a method in square to do this. See below..

  end

  def winning_condition?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].value == marker && @data[line[1]].value == marker && @data[line[2]].value == marker
    end
     false
  end

end

class Square
  attr_reader :value
  
  def initialize(value)
    @value = value
  end

  def mark(marker)
    @value = marker #Here because board is going to ask the square to mark itself, we give it a marking method to access the setter method
  end

  def empty?
    @value == ' '
  end
  
  def to_s
    @value 
  end
end

class Player
  attr_accessor :marker, :name
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end


class Game
  def initialize
    @board = Board.new
    @human = Player.new("Larry", "X")
    @computer = Player.new("Bat Computer", "O")
    @current_player = @human #current player starts off to be the human
  end

  def current_player_marks_square
    if current_player == @human
      begin
        puts "Choose a position #{@board.empty_positions} to place a piece:"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample #randomly selects one empty position
    end
    @board.mark_square(position, @current_player.marker)
  end

  def current_player_win?
    @board.winning_condition?(@current_player.marker) #we're punting to the board now because this is a board function.
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def play #this will be very similar to the solutions
    @board.draw
    loop do
      current_player_marks_square
      @board.draw
      if current_player_win?
        puts "The winner is #{@current_player.name}!"
        break
      elsif @board.all_squares_marked?
        puts "It's a tie!"
        break          
      else
        alternate_player
      end
    end
    puts "Bye"
  end
end

Game.new.play

