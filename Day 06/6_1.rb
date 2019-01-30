#!/usr/bin/ruby

# Get the input file
input = File.read("day_6_test.txt")

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
