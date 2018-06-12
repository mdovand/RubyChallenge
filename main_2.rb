require 'optparse'
require 'json'
require_relative 'user'
require_relative 'card'

options = {}
result = {}

#JSON import
fichier=File.read("input.json")
data_cards=JSON.parse(fichier)["loyalty_cards"]
data_rewards=JSON.parse(fichier)["rewards"]

OptionParser.new do |opt|
  opt.on('--user_id USER_ID') { |o| options[:user_id] = o }
  opt.on('--loyalty_card_id LOYALTY_CARD_ID') { |o| options[:loyalty_card_id] = o }
end.parse!



if options[:user_id] && User.new(options[:user_id].to_i)
    user=User.new(options[:user_id].to_i)
    result[:user] = user.info

    if options[:loyalty_card_id] && user.card_from_id(options[:loyalty_card_id].to_i)
    result[:loyalty_card] = user.card_from_id(options[:loyalty_card_id].to_i).info2
    else puts "loyalty_card_id invalid"
    end

end

puts JSON.pretty_generate(result)
