#!/usr/bin/ruby

# Read in the file and push each line of it to an array so you can use .each with it later

input = []
f = File.open("day_6_test.txt")
while line = f.gets do
	input << line
end

=begin

Find out how big the grid you need to figure things out is (largest x = rows, largest y = columns)
Start an array of arrays in the size of the grid you need
Each item in the grid should be 0
Go through the grid and fill in the second item in the hash with the Manhattan distance to (0,0)
For every item that's in your list
	Assign it an identifier
	
	For each square in the grid
		Pull the contents
			if it's a number, that's the straight Manhattan Distance
			if it's a hash, we've seen it before and the second item is the Manhattan Distance
		Calculate the Manhattan distance for that grid location from the square specified by the item
		If the extant Manhattan distance is smaller than that number, do nothing
		If it's larger, then push the identifier and the Manhattan distance to that grid square
	end
end
	
Eliminate anything that's on an edge (by definition it's unbounded on the edge side)

Count the number of times you've seen each value in the grid.

The largest count is the largest bounded area.

=end

# Determine the size of the necessary grid and set up an array of the coordinates with identifiers

largest_x = 0
largest_y = 0

ident = 1
identified = []

input.each do |coords|
	x, y = coords.split(",").map(&:to_i)
	
	if x > largest_x
		largest_x = x
	end
	
	if y > largest_y
		largest_y = y
	end
	
	identified << {"N" + ident.to_s => [x, y]}
	ident += 1
end

# Start a new x by y 2D array full of placeholders

grid = Array.new(largest_x){Array.new(largest_y) {|index| index}}

# The coordinates of each grid slot are grid[y][x], so I should be able to produce the Manhattan Distance if I can figure out how to pull the indexes for the 2D array.
row_num = 0

grid.each do |row|

	row.each do |item|
	
		puts item+row_num
		
	end
	row_num +=1
end

puts grid.inspect


# Pull the identifier and coordinates back out of the "identified" array

identified.each do |info|
	identity, coordinates = info.keys, info.values
	x = coordinates[0]
	y = coordinates[1]
end
	



