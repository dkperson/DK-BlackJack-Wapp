class Play::Player
  attr_reader :name
  attr_accessor :hand, :stand

  def initialize(name)
    @name = name
    @hand = []
  end



  def hand_total
    raise "No cards in hand" if hand.length == 0
    total = hand.map(&:value).reduce(:+)
    if has_ace? && total <= 11
      total += 10
    end
    total
  end

  def display_total
    total = hand.map(&:value).reduce(:+)
    if has_ace? && total < 11
      "#{total} or #{total+10}"
    elsif has_ace? && total == 11
      "#{total+10}"
    else
      "#{total}"
    end
  end

  def has_ace?
    hand.each { |card| return true if card.is_ace? }
    false
  end

  def status
    if hand_total == 21 && hand.length == 2
      :blackjack
    elsif hand_total > 21
      :bust
    elsif hand_total == 21 || stand == true
      :stand
    elsif hand_total < 21
      :ready
    else
      raise "Unknown status error"
    end
  end

  def play_options
    %w{hit stand}
  end
end
