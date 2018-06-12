class User

  attr_reader :user_id
  attr_accessor :cards

  @@data_rewards=JSON.parse(File.read("input.json"))["rewards"]
  #constructor from user_id and data
  def initialize(id)
    @user_id = id
    @cards = []

    @@data_rewards.each do |reward|
      if user_id == reward["user_id"]
        if card_from_id(reward["loyalty_card_id"])!=nil
          card_from_id(reward["loyalty_card_id"]).add_credit(reward["points"].to_i)
        else @cards.push(Card.new(reward["loyalty_card_id"]))
          card_from_id(reward["loyalty_card_id"]).add_credit(reward["points"].to_i)

        end
      end
    end
  end


  #methods
  def add_card(card)
    cards.push(card)
  end

  def card_from_id(id)
    cards.each do |card|
      if card.card_id == id
        return card
      end
    end
    return nil
  end

  def total_points
    total = 0
    cards.each do |card|
      total = total + card.card_total_points
    end
    return total
  end

  def info
    info = {
      id: user_id,
      total_points: total_points,
      loyalty_card: []
    }
    cards.each do |card|
    info[:loyalty_card].push(card.info)
    end
    return info
  end

end
