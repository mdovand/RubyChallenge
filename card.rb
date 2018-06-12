class Card

  attr_reader :card_id
  attr_accessor :points_credits

  @@data_cards=JSON.parse(File.read("input.json"))["loyalty_cards"]

  #constructor
  def initialize(card_id)
    @card_id = card_id
    @points_credits = Array.new
  end

  #methods
  def card_total_points
    sum = 0
    points_credits.each do |x|
      sum += x
    end
    return sum
  end

  def add_credit(credit)
    points_credits.push(credit)
  end

  def shop_name_from_id
    @@data_cards.each do |card|
      if card["id"] == card_id
        return card["name"]
      end
    end
  end

  def info
    info = {
      id: card_id,
      points: card_total_points,
      name: shop_name_from_id
    }
    return info

  end

  def info2
    info ={
      id: card_id,
      total_points: card_total_points,
    }
  end

end
