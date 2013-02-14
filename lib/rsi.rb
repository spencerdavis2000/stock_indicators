require 'pry'
class RSI

	attr_reader :gain, :loss, :average_gain, :average_loss, 
				:rs, :rsi, :price

	def initialize
		@price = {'QQQQ' => [43.13,42.66,43.42,44.57,44.22,44.18,44.03,45.35,
				  45.78,46.45,45.71,46.25,46.21,45.64,46.22,46.41,
				  46.03,46.00,46.28,46.28,45.61,46.03,45.89,46.08,
				  45.84,45.42,45.10,44.83,44.33,43.61,
				  44.15,44.09,44.34]}
		@gain = []
		@loss = []
		@average_gain = []
		@average_loss = []
		@rs = []
		@rsi = []
	end
	
	def read(price)
		price
	end
	def gain_loss(instrument)
		#===============================
		#First get change = previous - last
		# Then get the gains and loss
		@price_holder = instrument
		last = @price_holder.pop
		@price_holder.size.times do
			previous = @price_holder.pop
			difference = previous - last
			if difference >= 0
				@gain << difference.round(2)
				@loss << 0.0
			elsif difference <= 0
				@loss << difference.round(2)
				@gain << 0.0
			end
			last = previous
		end
	end
	#==================================
	# Next get the Avg Gain and Avg Loss
	#Average gain = first average gain, then formula
	#First Average Gain = Sum of Gains past 14 prices / 14
	#Average Gain = [(previous Average Gain)*13 + Current Gain]/14
	#Average Loss = [(previous Average Loss)*13 + current Loss]/14
	#The calculations after the first are used for smoothing by
	#Welles Wilder
	def calculate_average_gain(period)
		#calculate first value
		gain = @gain.dup
		n = 1
		first_average = (gain[0...period].inject{|sum,x|sum+x}/14).round(2)
		@average_gain << first_average
		# #calculate next values
		# gain.size.times do
		# 	next_value = ((@average_gain.last)*13 + gain[period+n])/14
		# 	n += 1
		# end
	end
	def calculate_average_loss

	end



	#===================================
	#Then get RS value and then the RSI
end

#binding.pry


