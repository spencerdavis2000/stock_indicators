#This is the calculation for the relative strength index (RSI)

Welles Wilder developed this indicator and is commonly used by traders to 
gauge the: momentum of a stock or instrument, as well as oversold and overbought
levels.  

This can also be used with price levels to show divergence (price going up and
RSI going down or vice versa)

30 and below is considered to be oversold
70 and above is considered to be overbought

As with all indicators, there is a duality.  In heavy trends, the RSI usually 
stays embeded 50 to 90 for a long time.  This is where it is more of a momentum
indicator.
However, this type of power usually happens less of the time, while most of the
time when the  market hits below 30 it will usually retrace back up, or if it
hits 70 or above it will usually retrace back down.

So, this is a pretty decent "exit indicator"

Calculations
===================
RSI = 100 - (100/(1+RS))

RS = Average Gain / Average Loss

difference = previous price - last price
if difference >= 0 it is called a "Gain" which goes in the @gain container.
elsif difference =< 0 it is called a "Loss" which goes into the @loss container.

Average Gain is calculated from the gain container by:
	1.  First value = the sum of last 14 (period = 14) values/14 
	2.  Next values = [(previous average gain)*13 + current gain]/14
The previous average gain comes from the @average_gain container and the 
current gain comes from the @gain container.

The same is calcualted to get the Average Loss and is put into the 
@average_loss container.  

BTW, when I used the word container, I am mean @average_loss = [] which is
an array.  However, I am using the term in terms of what it is doing which
is acting as a container to hold stuff for a while until I don't need it.

After this comes the RS calculation:
	RS = Average Gain/Average Loss
	so each element from the @average_gain and @average_loss will be
	calculated.  What is nice is they are both the same size 
	mathematically.

Last, since some stocks are $500 per share and some are $5 per share, the
RS value will vary greatly.  Therefore we have to apply the formula
	
	RSI = 100 - (100/(1+RS))
This puts all stocks to the scale of 0 to 100 no matter what the stock price.

There is a lot of number crunching when it comes to the RSI, but this 
indicator is very good as an exit indicator for already being in a trade, as
well as a momentum indicator when you have other information that a trend is
about to start or has already started.  In this case, the RSI is a good
confirmation indicator when it is above 50 for long and below 50 for short.












