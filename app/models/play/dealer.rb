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
        #puts "Players hand #{player.hand}"
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
        #push(player)
        #consolidate_split_hands([player])
      elsif player.hand_total > hand_total || status == :bust
        players_results[player] = "won"
      end
    end
    #players_results.each { |player| payout(player) }
    #consolidate_split_hands(players_results)
    players_results
  end

  def payout(player)
    if player.status == :blackjack
      player.won = player.bet*3
    else
      player.won = player.bet*2
    end
  end

  def push(player)
  end

  def split_hand(player, split_player)
    split_player.hand << player.hand.pop
    split_player.bet = player.bet
    hit(player)
    hit(split_player)
  end

  def consolidate_split_hands(winning_players)
    winning_players.each do |player|
      
    end
  end

end
