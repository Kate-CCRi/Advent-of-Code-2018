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

# Instantiate a new 2D array of 1000 arrays with 1000 '0's in each
grid = Array.new(1000) {Array.new(1000,0)}

# A hash to hold our potential IDs
candidates = {}

# For each item in the input (a "claim")
input.each do |claim|

=begin
Create an ID by splitting the claim on the "@" and taking the first piece.
Create coordinates and dimensions by splitting the last part of the claim split and splitting it again on ":"
=end
	id_num, claim = claim.split("@")
	coord, dim = claim.split(":")

	# Pull out extraneous characters, whitespaces, and newlines
	id = id_num.delete(' ').delete('#').chomp
	coord = coord.delete(' ').chomp
	dim = dim.delete(' ').chomp
	
	# Split the coordinates on "," and assign the values to x and y
	x, y = coord.split(",")
	
	# Split the dimensions on "x" and assign the values to w and h
	w, h = dim.split("x")
	
	# Explicitly cast everything to integers
	x = Integer(x)
	y = Integer(y)
	w = Integer(w)
	h = Integer(h)
	id = Integer(id)
	
	# Reset the coordinates into an array form, and push it into the candidates hash with the id as its hash ID
	coord_array = [x, y]
	candidates[id] = coord_array

	cell = 0
	
=begin
This block says:
	As many times as you have entries in w
		As many times as you have entries in h
			Add 1 to the grid locations described by those coordinates
			
=end	
	
	w.times do |x1|
    	h.times do |y1|
     		grid[x + x1][y + y1] += 1
     		cell = grid[x + x1][y + y1]
     		if cell > 1
    			candidates.delete_if {|key, value| key == id}
     		end
    	end
    end
end

=begin

TO TRY: Keep a record of every cell you've seen and how many times you've seen it, then remove every cell with a value > 2 from the hash and return the resulting matching ID

=end


# Take the grid array, flatten it, pick all cells where the number in them is greater than 1, and return that count.
part_one = grid.flatten.select { |cell| cell > 1 }.count
puts "The answer to Part One is #{part_one}."

puts candidates.count