require 'pry'
require 'colorize'

class RSI
	attr_reader :rsi, :rs, :average_loss, :average_gain, :loss, :gain 

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
		@gain_dup = @gain.dup
		first_average = (@gain_dup[0...period].inject{|sum,x|sum+x}/14).round(2)
		@average_gain << first_average
		#calculate next values
		n = 1

		#start at gain[period] to the end
		(period + 1).upto(@gain_dup.size) do
			value = period + n - 1
			a = ['Average Gain', @average_gain.last ]
			b = ['Gain', @gain_dup[value]]
			#puts a.to_s.red
			puts b.to_s.green
			temp = @average_gain.last * 13 + @gain_dup[value]
			next_value = (temp / 14)
			@average_gain << next_value
			n += 1
		end
	end
	def calculate_average_loss(period)
		@loss_dup = @loss.dup
		first_average = (@loss_dup[0...period].inject{|sum,x|sum+x}/14).round(2)
		@average_loss << first_average
		puts @average_loss.to_s.red
		n = 1
		(period + 1).upto(@loss_dup.size) do
			value = period + n - 1
			# a = ['Average Loss', @average_loss.last]
			# puts a.to_s.red
			temp = @average_loss.last * 13 + @loss_dup[value]
			next_value = (temp/14)
			@average_loss << next_value
			n += 1
		end
	end
	def calculate_rs
		@average_loss.size.times do |i|
			temp = (@average_gain[i]/@average_loss[i]).abs
			@rs << temp
		end
	end

	def calculate_rsi
		@average_loss.size.times do |i|
			temp = 100 - (100/(1+@rs[i]))
			@rsi << temp.round(2)
		end
	end
	def run
		gain_loss(@price["QQQQ"])
		calculate_average_gain(14)
		calculate_average_loss(14)
		calculate_rs
		calculate_rsi
	end

end
#binding.pry


