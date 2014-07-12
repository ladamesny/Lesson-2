require 'pry'

#How to play blackjack
#1) Create table (game)
#2) Ask name of player
#2) Decide how many decks of cards to play with
#2) Dealer shuffles cards
#3) Deal cards
#     - one for player
#     - one for dealer (face_down)
#     - another for player
#     - another for dealer (face_up)
#4) Calculate scores, only player score is known by the user
#     - If blackjack, find winner and end game
#5) Ask Player if they would like to hit or stay
#       - If hit, calculate score
#       	- If blackjack, find winner and end game
#       	- If bust, find winner and end game
#6) Dealer hits until 17 is reached
#        - Calculate score
#         - If blackjack, find winner and end game
#         - If bust, find winner and end game
#7) Still no blackjack and no bust
#         -find winner
#         -end game (ask to play again)
#
#

class Deck
  attr_accessor :deck_of_cards  

  def initialize
    @deck_of_cards = []
    ["Hearts", "Diamonds", "Clubs" , "Spades"].each do |suit|
      ["2","3","4","5","6","7", "8", "9", "10", "Jack", "Queen", "King", "Ace"].each do |value|
        @deck_of_cards << Card.new(suit, value)
      end
    end
    shuffle_cards!
  end

  def deal_card
    deck_of_cards.pop
  end

  def shuffle_cards!
    deck_of_cards.shuffle!
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end

class Player
  attr_accessor :name, :hand, :blackjack, :bust, :player_score

  def initialize(name)
    @name = name
    @hand = []
    @bust = false
    @blackjack = false
    @player_score = 0
  end

  def new_game
    self.hand = []
    self.bust = false
    self.blackjack = false
    self.player_score = 0
  end

  def show_hand
    count = 0
    self.hand.each do |card|
      count +=1
      puts "-Card #{count} : #{card.value} of #{card.suit}".center(80)
    end
  end

  def calculate_score
    score = 0
    self.hand.each do |card|
      if card.value == "Ace"
        score += 11
        if score > 21
          score -=10
        end
      elsif card.value == "King" || card.value == "Queen" || card.value == "Jack" 
        score +=10
      else
        score += card.value.to_i
      end
    end
    # #correct for Aces
    # self.hand.select {|e| e.value == "Ace"}.count.times do 
    #   score -=10 if self.player_score > 21
    # end
    self.player_score = score
    self.bust?
    self.blackjack?
    if self.blackjack == true
      system 'cls'
      puts "BLACKJACK".center(80) * 100
      gets
    end
    if self.bust == true
      puts "#{self.name} BUSTED!"
      gets
    end
    self.player_score
  end

  def bust?
    if self.player_score > 21
      self.bust = true
    end
  end

  def blackjack?
    if self.player_score == 21
      self.blackjack = true
    end
  end
end

class Table
  attr_accessor :table, :User, :Dealer, :Winner

  def initialize
  system 'cls'
  puts
  puts
  puts "Welcome to blackjack!".center(80)
  gets
  puts "What is your name?"
  name = gets.chomp
  @User = Player.new(name)
  @Dealer = Player.new("Dealer")
  @Winner = Player.new("")
  puts
  puts "Hello #{@User.name}! Let's play some blackjack!".center(80)
  @table = Deck.new
  gets
  end

  def find_winner
    #This is suppored to find the winner. winners Cases:
    #-Either player get blackjack
    #-Oppisite player busts
    #-Player with highest score
    #-It's a tie
    if self.User.blackjack == true
      self.User
    elsif self.Dealer.blackjack == true
      self.Dealer
    elsif self.User.bust == true
      self.Dealer
    elsif self.Dealer.bust == true
      self.User
    elsif self.User.player_score > self.Dealer.player_score
      self.User
    else
      self.Dealer
    end
  end

  def play
    keep_playing = true
    while keep_playing == true
      #Set up new_game
      self.User.new_game
      self.Dealer.new_game

      #Deal cards to players
      system 'cls'
        #Deal to user
      puts "Dealing first card to #{self.User.name}!\n\n".center(80)
      self.User.hand << self.table.deal_card
      puts "#{self.User.name} received a #{self.User.hand[0].value} of #{self.User.hand[0].suit}"
      gets
        #Deal to dealer
      puts "Dealing card to #{self.Dealer.name}!".center(80)
      self.Dealer.hand << self.table.deal_card
      gets
        #Deal to user
      puts  
      puts "Dealing second card to #{self.User.name}!\n\n".center(80)
      self.User.hand << self.table.deal_card
      gets
      puts "#{self.User.name} received a #{self.User.hand[1].value} of #{self.User.hand[1].suit}"
      gets
        #Deal to dealer
      puts "Dealing card to #{self.Dealer.name}!".center(80)
      self.Dealer.hand << self.table.deal_card
      gets
      puts "#{self.Dealer.name} received a #{self.Dealer.hand[1].value} of #{self.Dealer.hand[1].suit}"
      gets  

      #Calculate scores
      self.User.player_score = self.User.calculate_score
      self.Dealer.player_score = self.Dealer.calculate_score  

      # HIT OR STAY
      while self.User.player_score < 21 && self.User.bust == false && self.User.blackjack == false do
        system 'cls'
        puts "Dealer is showing #{self.Dealer.hand[1].value} of #{self.Dealer.hand[1].suit}".center(80)
        gets
        puts "#{self.User.name}, you have #{self.User.player_score} in your hand:".center(80)
        puts "CARDS:".center(80)
        self.User.show_hand
        puts
        puts "What would you like to do, #{self.User.name}? 1) hit or 2) stay?".center(80)
        answer = gets.chomp
        if !['1','2'].include?(answer)
          puts "Error: please enter either 1) hit or 2) stay?\n"
          gets
          next
        end
        
        system 'cls'
        
        if answer == "2"
          puts "#{self.User.name} decided to stay with a score of #{self.User.player_score}."
          puts "\nYOUR CARDS:".center(80)
          self.User.show_hand
          gets
          break
        end 

        system 'cls'
        puts "\n\n\n\n\n Dealing to #{self.User.name}".center(80)
        gets
        self.User.hand << self.table.deal_card
        puts "#{self.User.name} received a #{self.User.hand.last.value} of #{self.User.hand.last.suit}!"
        self.User.player_score = self.User.calculate_score
        self.User.show_hand
        puts " #{self.User.name} score is : #{self.User.player_score}!"
        gets
      end 

      #Dealer Shows Hand
      puts
      puts "______________________________________________________\n\n"
      puts "Dealer's Hand:".center(80)
      gets
      self.Dealer.show_hand
      gets
      puts "Dealer has #{self.Dealer.player_score}!".center(80)
      gets
      #Dealer Turn
      while self.Dealer.player_score < 17 && self.User.bust == false && self.User.blackjack == false
        system 'cls'
        puts "#{self.User.name}'s Score: #{self.User.player_score}\n"
        puts "______________________________________________________\n\n"
        puts "#{self.Dealer.name} draws card".center(80)
        gets
        self.Dealer.hand << self.table.deal_card
        self.Dealer.calculate_score
        self.Dealer.show_hand
        puts "#{self.Dealer.name} has a score of: #{self.Dealer.player_score}!"
        gets
      end 

      if self.User.player_score == self.Dealer.player_score
        puts "It's a Tie!"
      else
        self.Winner = self.find_winner
        puts "The Winner is: #{self.Winner.name}!"
        gets
        if self.Winner.name == self.User.name
          puts "Congratulations!"
        else
          puts "Better Luck Next Time!"
        end
      end
      gameover = false
      while gameover == false
        puts "Play again?(y/n)"
        answer = gets.chomp
        if !['y','n'].include?(answer.downcase)
          puts "Error: Please enter (y/n)"
          next
        end 
        if answer.downcase != 'y'
          keep_playing = false
          puts "Thanks for playing blackjack!"
          gameover = true
          gets
        else
          gameover = true
        end
      end
    end
  end
end

Table.new.play

      