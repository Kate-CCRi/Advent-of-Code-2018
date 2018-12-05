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

grid = Array.new(1000) {Array.new(1000) {Set.new}}

# A new set to hold my potential candidate IDs.
candidates = Set.new

# For each item in the input (a "claim")
input.each do |claim|

=begin
This splits the claim into three pieces and then splits the second one again. The command is evaluated left to right, so it gets the claim and splits it on the @, which splits the original line into the claim ID on one side, and the starting coordinate and the dimensions on the other. Then it says "take the last part of that split" (so just the coordinate and dimensions) and split *that* on ":", and assign the two values returned to the two variables.

It also uses "chomp" and "delete" to do some cleanup on the things it's found in during the split. Note that you *cannot* cast 'coord' and 'dim' to integers here because you need to split them further in the next step.
=end
	
	id = claim.split("@").first.chomp.delete("#").delete(" ")
	
	coord, dim = claim.delete(' ').chomp.split("@").last.split(":")
	
	# Split the coordinates on "," and assign the values to x and y. Since "map" iterates over an array and produces a new array, this casts 'x' and 'y' to integers as part of the splitting process.
	
	x, y = coord.split(",").map(&:to_i)
	
	# Split the dimensions on "x" and assign the values to w and h, using map to make them integers while you're at it.
	
	w, h = dim.split("x").map(&:to_i)

	# Put the ID of the claim you're looking at into the "candidates" set	

	candidates.add(id)

=begin
Go through the dimensions described by each claim. 
If the set in that cell has anything in it:
	- delete the current candidate from the candidate set
	- delete any IDs contained within the cell from the candidate set
Otherwise, add the current ID to the cell you're looking at.
=end	
	
	w.times do |x1|
    	h.times do |y1|
     		cell = grid[x + x1][y + y1]
     		
     		if cell.any?
     			candidates.delete(id)
     			cell.each do |c|
     				candidates.delete(c)
     			end
     		else
     			cell.add(id)
     		end
     	end	
     end			
 end
    
# Output a human-readable version of the set with the remaining claim ID in it.

puts candidates.inspect