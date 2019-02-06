#!/usr/bin/ruby

# Read in the file and push each line of it to an array so you can use .each with it later

input = []
f = File.open("day_6_test.txt")
while line = f.gets do
	input << line.chomp
end

# You now have a clean array where each entry is one set of coordinates. 

# Next step, split the coordinates into x and y values and find the maximum values for each to see how big our grid needs to be.

coordinates = []

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
	
	id = ('a'..'z').to_a.shuffle.first(3).join # This creates a random identifier for each set of coordinates

	coordinates << [x, y, id] # This pushes the coordinates and their ID to a new array
	
end


# This creates a grid of size largest_x by largest _y and fills it with empty arrays. (NOTE: The y value creates the stack of arrays, the x value determines the size of each array in the stack.)
grid = Array.new(y_max + 1){Array.new(x_max + 2) {Array.new}}


# This fills the empty arrays with the Manhattan distance to (0, 0)
row_num = 0

grid.each do |row|

	row.each_index do |item|
	
		row[item] = item + row_num.to_i
		
	end
	
	row_num +=1
	
end

# This pulls the x, y, and ID of each set of given coordinates back out to work with

coordinates.each do |identified|

	x_id = identified[0]
	y_id = identified[1]
	id = identified[2]

# Iterate through each item in the grid and calculate the Manhattan distance between that item and the current set of coordinates. The current Y is the index from the grid, and the current X is the index from the row.

	grid.each_index do |y_current|
	
		grid[y_current].each_index do |x_current|
		
			distance = (x_current - x_id).abs + (y_current - y_id).abs
				
			if grid[y_current][x_current].class == Integer
			
				grid[y_current][x_current] = [distance, id]
			
			elsif grid[y_current][x_current][0] > distance
			
				grid[y_current][x_current] = [distance, id]
				
			elsif grid[y_current][x_current][0] == distance
			
				grid[y_current][x_current] << id
				
			end
		end
	end
end

puts grid.inspect
