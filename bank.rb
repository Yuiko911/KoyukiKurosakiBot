require 'json'

class Bank
	def initialize
		@bal = {}
 	end

	# Getting balance
	def getBalanceAll
		return @bal
	end
	def getUserBalance username
		return 0 unless @bal[username] != nil
		return @bal[username]
	end
	
	# Adding money
	def addPyroTo username, numOfPyro
		@bal[username] ||= 0 # Set value to 0 if the key doesn't exist
		@bal[username] += numOfPyro
	end

	# Saving and loading balance
	def saveToJSON filename
		File.write filename, JSON.dump(@bal)
	end
	def loadFromJSON filename
		@bal = JSON.parse File.open(filename).read
	end

	# Test
	def setBalance=(b)
		@bal = b
	end
	def to_s
		"Total balance: #{@bal}"
	end
end
