#!/usr/bin/ruby

# Read in the file and push each line of it to an array so you can use .each with it later

input = []
f = File.open("day_6_input.txt")
while line = f.gets do
	input << line.chomp
end

# You now have a clean array where each entry is one set of coordinates. 

# Next step, split the coordinates into x and y values and find the maximum values for each to see how big our grid needs to be.

coordinates = {}

x_max = 0
y_max = 0

input.each do |set|
	x = set.split(",").first.to_i
	y = set.split(", ").last.to_i # Note that the split here is comma-space to pull the extra space out automatically
	
	if x > x_max
		x_max = x
	end
	
	if y > y_max
		y_max = y
	end
	
	id = ('a'..'z').to_a.shuffle.first(3).join # This creates a random 3-letter identifier for each set of coordinates

	coordinates[id] = [x, y] # This pushes the coordinates and their ID to the coordinates hash
	
end

# This creates a grid of size largest_x by largest _y and fills it with 0s. (NOTE: The y value creates the stack of arrays, the x value determines the size of each array in the stack. Since we are starting with 0 as our top row and first column, and would like at least a one-space edge from each point, we must add an offset to the size of our grid to accomodate that.)
grid = Array.new(y_max + 1){Array.new(x_max + 2, 0)}


# Go through the coordinates one by one, calculate its Manhattan distance to each point, and add that distance to the sum in the grid slot
coordinates.each do |id, coords|

	x = coords[0]
	y = coords[1]

	grid.each_index do |y_current|
	
		grid[y_current].each_index do |x_current|
		
			dist = (x_current - x).abs + (y_current - y).abs
			
			grid[y_current][x_current] += dist
			
		end
	end
end

# Turn the grid into a 1D array of only items smaller than our desired distance
newgrid = grid.flatten.delete_if {|item| item >= 10000}

# Return the count of those items
puts newgrid.count
	