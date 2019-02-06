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
	
	id = ('a'..'z').to_a.shuffle.first(3).join # This creates a random 3-letter identifier for each set of coordinates

	coordinates << [x, y, id] # This pushes the coordinates and their ID to a new array
	
end


# This creates a grid of size largest_x by largest _y and fills it with empty arrays. (NOTE: The y value creates the stack of arrays, the x value determines the size of each array in the stack. Since we are starting with 0 as our top row and first column, and would like at least a one-space edge from each point, we must add an offset to the size of our grid to accomodate that.)
grid = Array.new(y_max + 1){Array.new(x_max + 2) {Array.new}}


# This fills the empty arrays with the Manhattan distance to (0, 0)
row_num = 0

grid.each do |row|

	row.each_index do |item|
	
		row[item] = item + row_num.to_i
		
	end
	
	row_num +=1
	
end

totals = {}

coordinates.each do |x, y, id|

	totals[id] = 0

# Iterate through each item in the grid and calculate the Manhattan distance between that item and the current set of coordinates. The current Y is the index from the grid, and the current X is the index from the row.

	grid.each_index do |y_current|
	
		grid[y_current].each_index do |x_current|
		
			distance = (x_current - x).abs + (y_current - y).abs

# This puts the ID of the coordinates with the smallest Manhattan distance into the slot in the grid, or adds the ID if the distances are the same. Note that the first "if" only has an effect on the first run, since after that there will always be a distances to compare with.

# Also note that x_current and y_current are the *indexes* of the grid slot you're working with, so you need to specify the content you're accessing as well as the slot to get the distance back.

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

# Iterate over the ID array, and for each ID, count the number of times it appears in the grid. Break if the index of the slot containing the ID is 0, x_max, or y_max. Push the remaining IDs and counts to a new array, then return the largest count.

puts totals.inspect 

coordinates.each do |x, y, id|
	
count = 0
	
	grid.each_index do |y_current|
	
		grid[y_current].each_index do |x_current|
		
			if ((grid[y_current] == grid.first || grid[y_current] == grid.last)  && grid[y_current][x_current].include?(id))

				totals.delete(id)
				
			elsif ((grid[y_current][x_current] == grid[y_current].first || grid[y_current][x_current] == grid[y_current].last) && grid[y_current][x_current].include?(id))

				totals.delete(id)
				
			elsif (grid[y_current][x_current].include?(id) && grid[y_current][x_current].length == 2)
				
				count += 1	
				
			end
		end
	end
		
totals[id] = count
	
end


puts totals.inspect
puts totals.max_by {|x| x.last}