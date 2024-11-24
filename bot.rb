require './bank'

require 'discordrb'
require 'dotenv'
Dotenv.load

bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix: 'koyuki ', channels: [ENV['CASINO_CHAN_ID']]

globalbank = Bank.new
globalbank.loadFromJSON 'bal.json'

# Admin commands
bot.command :prison, required_roles: [ENV['BIG_SISTER_ROLE_ID']], description: 'Stop the bot' do |event|
	event.respond "😭"
	puts 'Shutting down from Discord'
	bot.stop
end

bot.command :'balance-all', description: 'Reply with everyones balance' do |event|
	event.respond "#{globalbank.getBalanceAll}"
end

# Money
bot.command :balance, description: 'Reply with users balance' do |event|
	userbalance = globalbank.getUserBalance event.author.username

	if userbalance == 0
		event.message.reply! 'You don\'t have any money :sob:'
	else
		event.message.reply! "#{event.author.mention} has #{userbalance} #{bot.emoji(ENV['PYRO_EMO']).use}"
	end

end

bot.command :'add-money', description: "Add money to users balance" do |event, *args|
	newbalance = globalbank.addPyroTo event.author.username, args[0].to_i 
	event.message.reply! "You defrauded the bank of #{args[0].to_i} #{bot.emoji(ENV['PYRO_EMO']).use}. You now have #{newbalance} #{bot.emoji(ENV['PYRO_EMO']).use}!"
end

# LET'S GO GAMBLING
bot.command :'pile-ou-face', description: "Simple pile ou face"  do |event|
	if rand(2) == 1
		event.message.reply! "Pile!", mention_user: true
	else
		event.message.reply! "Face!", mention_user: true
	end
end

# Hehe
bot.command :balls do |event|
	event.message.reply! "balls, cock even", mention_user: true
end

at_exit do
	globalbank.saveToJSON 'bal.json'
	bot.stop
end
bot.mode = :error

bot.run(background: true)
puts "Koyuki running, nihaha"
bot.send_message ENV['CASINO_CHAN_ID'], 'Koyuki online!'
bot.join

# Pile ou face
# Gacha (78.5, 18.5, 3)
