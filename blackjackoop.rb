# # 1. Major nouns in blackjack
# Write out your requirement in paragraph words
# extract major nouns and this will map to classes
# and then you want to extract major verbs
# and this will map to instance methods
# and then you want to group instance methods into classes
# Then you'll want to extract major nouns and map that to classes


#   -Player
#   -Dealer
#   -Deck
#   -Card
# when you need a setter method, use self
class players
  attr_accessor :name, :score, :bust, :blackjack, :hand
  
  def initialize(name)
    @name = n
    @score = 0
    @bust = false
    @blackjack = false
    @hand = []
    puts "Hi #{name}, let's play some blackjack!\n\n".center(80)
    gets
  end

  def draw_card
    self.hand << deal
  end

  def update_score!
    
    hand.each do |card|
      if card[1] == "Ace"
        self.score+= 11
      elsif card[1].to_i == 0 #Jack, Queen or King
        self.score+= 10
      else
        self.score+= card[1].to_i
      end
    end
      self.hand.select{|e| e[0] == 'Ace'}.count.times do
        self.score -=10 if self.score > 21
      end
  end

  def bust?
    if self.score >21
      self.bust = true
    end
  end

  def blackjack?
    if self.score == 21
      self.blackjack = true
    end
  end

end

class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value =v
  end
  #think about verbs in the card
  #pring
  def to_s
      "This is the card! #{suit}, #{value}"
  end
  #you might have a tendency to create a method to calculate the total value
  #but that is not a property of the actual card. You want to keep that separate
  #incase you want to use this class for another game such as Poker.
  #You want to keep this class as true to the actual object you're representing.
  #So this is pretty much what we need for a card.
end

class Deck

  attr_accessor :cards
  
  def initialize(num_decks) #you can change number of decks here
    @cards = [] #this will hold our raw data
    ["Hearts", "Diamonds", "Spades", "Cards"].each do |suit|
      ['2','3','4','5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].each do |face_value|
        @cards << Card.new(suit, face_value)
        #we're not using product here, because we're not using a nested array structure to hold our cards
        #our cards are held in the card object above
      end
    end
    @cards = @cards * num_decks
    scramble!
  end
  
  def scramble!
    cards.shuffle!
  end

  def deal
    cards.pop
  end
  #we create the "deal" method in the "deck" level instead of the "dealer" level, because it's the deck that will perform this behavior
  #the "dealer" will ask the "deck" to "deal" itself
end

class User < players#[DO I NEED TO SET THIS AS SUBCLASS TO DECK IN ORDER TO USE DEAL?]


end

# class Dealer < players
#  
# end

# #this is the game engine
# class Blackjack
#   attr_accessor :player, :dealer, :deck

#   def initialize
#     @player = Player.new("Bob")
#     @dealer = Dealer.new("Dealer")
#     @deck = Deck.new
#   end

#   def run
#   #procedural section
#     deal_cards
#     show_flop
#     player_turn
#     dealer_turn
#     who_won?

#   end


# end



# #at some point you need a procedural section to use the classes and make our game

# Blackjack.new.run

# game.run

cards = Deck.new(1)
puts cards.cards