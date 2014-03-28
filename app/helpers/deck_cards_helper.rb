module DeckCardsHelper
  def deck_card_to_view(deck_card)
      image_tag File.join("Deck/#{deck_card.face.downcase}_of_#{deck_card.suit.downcase}.png") , size: '150'
  end

end