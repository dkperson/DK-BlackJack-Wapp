class Play::Dealer < Play::Player
  attr_reader :deck_stack

  def initialize
    super("Dealer")
    @deck_stack = Play::DeckStack.new
  end

  def deal(players)
    2.times do
      players.each do |player|
        player.hand << deck_stack.take_card
      end
      hand << deck_stack.take_card
    end
  end

  def hit(player)
    player.hand << deck_stack.take_card
  end

  def show_first
    hand[0]
  end

  def winners(players)
  players_results = Hash.new
    players.each do |player|
      if player.hand_total < hand_total && status != :bust || player.status == :bust
        players_results[player] = "loss"
      elsif player.hand_total == hand_total
        players_results[player] = "tie"
      elsif player.hand_total > hand_total || status == :bust
        players_results[player] = "win"
      end
    end
    players_results
  end

end
