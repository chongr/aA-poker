require_relative 'deck'
class Hand

  COMBOS = {
    high_card: 0,
    one_pair: 1,
    two_pair:2,
    three_kind: 3,
    straight: 4,
    flush: 5,
    full_house: 6,
    four_kind: 7,
    straight_flush: 8,
    royal_flush: 9
  }

  attr_reader :cards_in_hand

  def initialize(deck)
      @cards_in_hand = deck.draw(5)
  end

  def discard(*cards_to_discard)
    cards_to_discard.each do |card|
      @cards_in_hand.delete(card)
    end
  end

  def replenish(deck)
    @cards_in_hand.concat(deck.draw(5-cards_in_hand.length))
  end

  def is_flush? #=>
    suit = @cards_in_hand.first.suit
    @cards_in_hand.each do |card|
      return false if card.suit != suit
    end
    true
  end

  def is_straight?
    sorted_hand = @cards_in_hand.sort {|card1, card2| card1.card_value <=> card2.card_value}

    return true if sorted_hand.last.card_value - sorted_hand.first.card_value == 12
    return true if sorted_hand.last.card_value - sorted_hand.first.card_value == 4
    false
  end

  def is_straight_flush?
    return true if is_straight? && is_flush?
    false
  end

  def four_kind?
    unique = @cards_in_hand.uniq {|card| card.card_value}
    return true if unique.length == 2
    false
  end

  def three_kind?
    @cards_in_hand.each do |card1|
      cardcount = 0
      @cards_in_hand.each do |card2|
        cardcount += 1 if card1.card_value == card2.card_value
      end
      return true if cardcount == 3
    end

    false
  end

  def one_pair?
    unique = @cards_in_hand.uniq {|card| card.card_value}
    return true if unique.length == 4
    false
  end

  def full_house?

  end
end
