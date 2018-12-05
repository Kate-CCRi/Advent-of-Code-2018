#!/usr/bin/ruby

# Some things we need to start

# An array to hold our lines that we're about to read in
input = []

# Get the input file
f = File.open("day_3_input.txt")

# Read each line of the file and put its value into the array
while line = f.gets do
	input << line
end


# Creates a new nested array: 1000 rows containing new arrays, each of which contains 1000 '0's.

grid = Array.new(1000) {Array.new(1000, 0)}

# A new array to hold my potential candidate IDs.
candidates = []

# For each item in the input (a "claim")
input.each do |claim|

=begin
This splits the claim into three pieces and then splits the second one again. The command is evaluated left to right, so it gets the claim and splits it on the @, which splits the original line into the claim ID on one side, and the starting coordinate and the dimensions on the other. Then it says "take the last part of that split" (so just the coordinate and dimensions) and split *that* on ":", and assign the two values returned to the two variables.

It also uses "chomp" and "delete" to do some cleanup on the things it's found in during the split. Note that you *cannot* cast 'coord' and 'dim' to integers here because you need to split them further in the next step.
=end
	
	id = claim.split("@").first.chomp.delete("#")
	
	coord, dim = claim.delete(' ').chomp.split("@").last.split(":")
	
	# Split the coordinates on "," and assign the values to x and y. Since "map" iterates over an array and produces a new array, this casts 'x' and 'y' to integers as part of the splitting process.
	
	x, y = coord.split(",").map(&:to_i)
	
	# Split the dimensions on "x" and assign the values to w and h, using map to make them integers while you're at it.
	
	w, h = dim.split("x").map(&:to_i)

	# Put the ID of the claim you're looking at into the "candidates" array

	candidates << id
	puts candidates
	
=begin
This block says:
	As many times as you have entries in w
		As many times as you have entries in h
			Push the ID that made you go to that coordinate into the set at that spot on the grid.
=end	
	
	w.times do |x1|
    	h.times do |y1|
     		grid[x + x1][y + y1] +=1
     		if grid[x + x1][y + y1] > 1
				candidates.pop
			end
     	end
    end
 end
    
=begin
Now you have a grid where each grid cell contains one copy of each claim ID that made you visit that cell.

So. Iterate over the grid by claim *again*, and for every cell that has more than one thing in it, remove that claim from your list of possibilities.
=end 

puts candidates.count	