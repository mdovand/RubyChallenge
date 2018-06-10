require 'optparse'
require 'json'

options = {}
result = {}

OptionParser.new do |opt|
  opt.on('--user_id USER_ID') { |o| options[:user_id] = o }
  opt.on('--loyalty_card_id LOYALTY_CARD_ID') { |o| options[:loyalty_card_id] = o }
end.parse!


fichier=File.read("input.json")
$data_cards=JSON.parse(fichier)["loyalty_cards"]
data_rewards=JSON.parse(fichier)["rewards"]


def shop_name_from_id(id)
  $data_cards.each do |card|
    if id==card["id"]
      return card["name"]
    end
  end
end

if options[:user_id]
  result[:user] = {
    id: options[:user_id],
    total_points: 0,
    loyalty_cards: []
  }

  data_rewards.each do |user|
    if options[:user_id].to_i==user["user_id"]
      result[:user][:total_points]+=user["points"]
      lc = { id: user["loyalty_card_id"], points: user["points"], name: shop_name_from_id(user["loyalty_card_id"]) }
      result[:user][:loyalty_cards].push(lc)
    end
  end
end


if options[:loyalty_card_id]
  total = 0
  result[:user][:loyalty_cards].each do |card|
    if card[:id]==options[:loyalty_card_id].to_i
    total += card[:points]
    end
  end

  result[:loyalty_card] = {
    id: options[:loyalty_card_id].to_i,
    total_points: total
  }


end

puts JSON.pretty_generate(result)
