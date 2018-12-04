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

end
