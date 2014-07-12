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
    hand = []
    bust = false
    blackjack = false
    player_score = 0
  end
 
  def show_hand
    count = 0
    hand.each do |card|
      count +=1
      puts "-Card #{count} : #{card.value} of #{card.suit}".center(80)
    end
  end
 
  def calculate_score
    score = 0
    hand.each do |card|
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
    player_score = score
    bust?
    blackjack?
    if blackjack == true
      system 'cls'
      puts "BLACKJACK".center(80) * 100
      gets
    end
    if bust == true
      puts "#{name} BUSTED!"
      gets
    end
    player_score
  end
 
  def bust?
    if player_score > 21
      bust = true
    end
  end
 
  def blackjack?
    if player_score == 21
      blackjack = true
    end
  end
end
 
class Table
  attr_accessor :table, :user, :dealer, :winner
 
  def initialize
    system 'cls'
    puts
    puts
    puts "Welcome to blackjack!".center(80)
    gets
    puts "What is your name?"
    name = gets.chomp
    @user = Player.new(name)
    @dealer = Player.new("Dealer")
    @winner = Player.new("")
    puts
    puts "Hello #{user.name}! Let's play some blackjack!".center(80)
    @table = Deck.new
    gets
  end
 
  def find_winner
    #This is suppored to find the winner. winners Cases:
    #-Either player get blackjack
    #-Oppisite player busts
    #-Player with highest score
    #-It's a tie
    if user.blackjack == true
      user
    elsif dealer.blackjack == true
      dealer
    elsif user.bust == true
      dealer
    elsif dealer.bust == true
      user
    elsif user.player_score > dealer.player_score
      user
    else
      dealer
    end
  end
 
  def play
    keep_playing = true
    while keep_playing == true
      #Set up new_game
      user.new_game
      dealer.new_game
 
      #Deal cards to players
      system 'cls'
        #Deal to user
      puts "Dealing first card to #{user.name}!\n\n".center(80)
      user.hand << table.deal_card
      puts "#{user.name} received a #{user.hand[0].value} of #{user.hand[0].suit}"
      gets
        #Deal to dealer
      puts "Dealing card to #{dealer.name}!".center(80)
      dealer.hand << table.deal_card
      gets
        #Deal to user
      puts
      puts "Dealing second card to #{user.name}!\n\n".center(80)
      user.hand << table.deal_card
      gets
      puts "#{user.name} received a #{user.hand[1].value} of #{user.hand[1].suit}"
      gets
        #Deal to dealer
      puts "Dealing card to #{dealer.name}!".center(80)
      dealer.hand << table.deal_card
      gets
      puts "#{dealer.name} received a #{dealer.hand[1].value} of #{dealer.hand[1].suit}"
      gets
 
      #Calculate scores
      user.player_score = user.calculate_score
      dealer.player_score = dealer.calculate_score
 
      # HIT OR STAY
      while user.player_score < 21 && user.bust == false && user.blackjack == false do
        system 'cls'
        puts "Dealer is showing #{dealer.hand[1].value} of #{dealer.hand[1].suit}".center(80)
        gets
        puts "#{user.name}, you have #{user.player_score} in your hand:".center(80)
        puts "CARDS:".center(80)
        user.show_hand
        puts
        puts "What would you like to do, #{user.name}? 1) hit or 2) stay?".center(80)
        answer = gets.chomp
        if !['1','2'].include?(answer)
          puts "Error: please enter either 1) hit or 2) stay?\n"
          gets
          next
        end
 
        system 'cls'
 
        if answer == "2"
          puts "#{user.name} decided to stay with a score of #{user.player_score}."
          puts "\nYOUR CARDS:".center(80)
          user.show_hand
          gets
          break
        end
 
        system 'cls'
        puts "\n\n\n\n\n Dealing to #{user.name}".center(80)
        gets
        user.hand << table.deal_card
        puts "#{user.name} received a #{user.hand.last.value} of #{user.hand.last.suit}!"
        user.player_score = user.calculate_score
        user.show_hand
        puts " #{user.name} score is : #{user.player_score}!"
        gets
      end
 
      #Dealer Shows Hand
      puts
      puts "______________________________________________________\n\n"
      puts "Dealer's Hand:".center(80)
      gets
      dealer.show_hand
      gets
      puts "Dealer has #{dealer.player_score}!".center(80)
      gets
      #Dealer Turn
      while dealer.player_score < 17 && user.bust == false && user.blackjack == false
        system 'cls'
        puts "#{user.name}'s Score: #{user.player_score}\n"
        puts "______________________________________________________\n\n"
        puts "#{dealer.name} draws card".center(80)
        gets
        dealer.hand << table.deal_card
        dealer.calculate_score
        dealer.show_hand
        puts "#{dealer.name} has a score of: #{dealer.player_score}!"
        gets
      end
 
      if user.player_score == dealer.player_score
        puts "It's a Tie!"
      else
        winner = find_winner
        puts "The Winner is: #{winner.name}!"
        gets
        if winner.name == user.name
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