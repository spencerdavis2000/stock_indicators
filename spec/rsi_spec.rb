$LOAD_PATH.unshift File.expand_path('../', __FILE__)
require 'rsi'

describe RSI do

	before(:all) do
		@price = {'QQQQ' => [43.13,42.66,43.42,44.57,44.22,44.18,44.03,45.35,
				  45.78,46.45,45.71,46.25,46.21,45.64,46.22,46.41,
				  46.03,46.00,46.28,46.28,45.61,46.03,45.89,46.08,
				  45.84,45.42,45.10,44.83,44.33,43.61,
				  44.15,44.09,44.34]}
		
		@rsi = RSI.new
	end

					  
	it "should read the prices" do
		@rsi.read(@price["QQQQ"][0]).should == 43.13
	end
	it "should calculate Gain and Loss" do
		#gain = previous price - last price if >= 0
		#loss = previous price - last price if <= 0 
		@rsi.gain_loss(@price["QQQQ"])
		@rsi.gain.should == [0.0, 0.06, 0.0, 0.72, 0.50, 0.27, 0.32, 0.42, 
								0.24, 0.0, 0.14, 0.0, 0.67, 0.0, 0.0, 0.03, 
								0.38, 0.0, 0.0, 0.57, 0.04, 0.0, 0.74, 0.0, 
								0.0, 0.0, 0.15, 0.04, 0.35, 0.0, 0.0, 0.47]

		@rsi.loss.should == [-0.25, 0.0, -0.54, 0.0, 0.0, 0.0, 0.0, 
								0.0, 0.0, -0.19, 0.0, -0.42, 0.0, 0.0, -0.28, 
								0.0, 0.0, -0.19, -0.58, 0.0, 0.0, -0.54, 0.0, 
								-0.67, -0.43, -1.32, 0.0, 0.0, 0.0, -1.15, 
								-0.76, 0.0]

	end
	it "should calculate Average Gain" do
		#First Average Gain = Sum of Gains past 14 prices / 14
		#Average Gain = [(previous Average Gain)*13 + Current Gain]/14
		#@rsi.average_gain.should == [0.24, 0.22, 0.21, 0.22, 0.20, 0.22, 0.20, 0.19,
										#0.22, 0.20, 
		@rsi.average_gain(14).should == [0.24]
	end
	it "should calculate Average Loss" do
		#First Average Loss = Sum of Losses past 14 prices / 14
		#Average Loss = [(previous Average Loss)*13 + current Loss]/14

	end

	it "should calculate RS = Average Gain / Average Loss" do

	end
	it "should calcualte RSI = 100 - (100/(1 + RS))" do

	end
end