class Play::DeckStack
  attr_reader :decks
  NUMBER_OF_DECKS = 1
  
  def initialize
    @decks = []
    fill_deck_stack
    @decks.shuffle!
  end

  def fill_deck_stack
    NUMBER_OF_DECKS.times do
      @decks += generate_deck
    end
  end

  def generate_deck
    deck = []
    %w{Spades Clubs Hearts Diamonds}.each do |suit|
      deck << Play::DeckCard.new(suit, 'Ace', 1)
      2.upto(10) { |i| deck << Play::DeckCard.new(suit, i.to_s, i) }
      %w{Jack Queen King}.each { |face| deck << Play::DeckCard.new(suit, face, 10) }
    end
    deck
  end

  def take_card
    raise "No cards are left in the deck!" if @decks.length == 0
    @decks.pop
  end
end
