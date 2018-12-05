#!/usr/bin/ruby

require 'set'

# Some things we need to start

# An array to hold our lines that we're about to read in
input = []

# Get the input file
f = File.open("day_3_input.txt")

# Read each line of the file and put its value into the array
while line = f.gets do
	input << line
end
=begin
This creates a new nested array -- 1000 rows containing new arrays, each of which contains 1000 new sets, which will be used to hold the IDs we've seen as we go through the grid.

So our array now looks like this - using {} for a set rather than for a hash:
[
	[{},{},{},...{}]
	[{},{},{},...{}]
	...
]

=end

grid = Array.new(1000) {Array.new(1000) {Set.new} }

# For each item in the input (a "claim")
input.each do |claim|

=begin
This line splits the claim into two pieces twice. The command is evaluated left to right, so it gets the claim and splits it on the @, which splits the original line into the claim ID on one side, and the starting coordinate and the dimensions on the other. Then it says "take the last part of that split" (so just the coordinate and dimensions) and split *that* on ":", and assign the two values returned to the two variables.
=end
	
	id = claim.split("@").first.chomp.delete("#")
	
	coord, dim = claim.delete(' ').chomp.split("@").last.split(":").map(&:to_i)
	
	# Split the coordinates on "," and assign the values to x and y. Since "map" iterates over an array and produces a new array, this casts 'x' and 'y' to integers as part of the splitting process.
	x, y = coord.split(",")
	
	# Split the dimensions on "x" and assign the values to w and h
	w, h = dim.split("x")
	
=begin
This block says:
	As many times as you have entries in w
		As many times as you have entries in h
			Push the ID that made you go to that coordinate into the set inside the grid array
=end	
	
	w.times do |x1|
    	h.times do |y1|
     		grid[x + x1][y + y1] << id
     	end
    end
end