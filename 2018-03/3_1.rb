#!/usr/bin/ruby

# Some things we need to start

input = [] # An array to hold our lines that we're about to read in

# Get the input file

f = File.open("day_3_input.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input << line
end	

# Instantiate a new 2D array of 1000 arrays with 1000 '0's in each
grid = Array.new(1000) {Array.new(1000,0)}

# For each item in the input (a "claim")
input.each do |claim|

=begin
This line splits the claim into two pieces twice. The command is evaluated left to right, so it gets the claim and splits it on the @, which splits the original line into the claim ID on one side, and the starting coordinate and the dimensions on the other. Then it says "take the last part of that split" (so just the coordinate and dimensions) and split *that* on ":", and assign the two values returned to the two variables.
=end

	coord, dim = claim.split("@").last.split(":")

	# Pull whitespaces out
	coord = coord.delete(' ')
	dim = dim.delete(' ')
	
	# Split the coordinates on "," and assign the values to x and y
	x, y = coord.split(",")
	
	# Split the dimensions on "x" and assign the values to w and h
	w, h = dim.split("x")
	
=begin
This block says:
	As many times as you have entries in w
		As many times as you have entries in h
			Go to the grid coordinates for that square and put a 1 in it
=end	
	
	w.times do |x1|
    	h.times do |y1|
     		grid[x + x1][y + y1] += 1
     	end
    end
end

# Take the grid array, flatten it, pick all cells where the number in them is greater than 1, and return that count.
puts grid.flatten.select { |cell| cell > 1 }.count