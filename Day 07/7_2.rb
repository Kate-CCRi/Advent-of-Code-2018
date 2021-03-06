#!/usr/bin/ruby

# Read in the input file line by line

words = []

File.readlines('day_7_input.txt').each do |line|
	words << line.split(" ")	
end

# Create hashes to keep the steps in.

todo = Hash.new { |hash, key| hash[key] = []}
blockers = Hash.new { |hash, key| hash[key] = []}

# Make an array for all the names of the steps so you can iterate with it later
steps = []

# Set up a hash dictionary of letters to times
timing = {}

counter = 60

("A".."Z").each do |letter|

	timing[letter] = counter
	
	counter += 1
end

# Take each line and pull out the step names in order and put them into the various hashes and arrays

words.each do |line|

	first = line[1]
	second = line[7]
	
	todo[first] << second
	blockers[second] << first
	
	steps << first
	steps << second
	
	steps.uniq!
	
end

options = []
ordered = []

# Find the starting points for processing

todo.each do |parent, children|

	unless blockers.key?(parent)
		options << parent
	end
	
	options.sort!.uniq!
		
end

# Thoughts: if you have an array where each worker is a slot, you can pass the letters through the array and then add their timing to the count when they get to done? So they go from options to working to ordered and their count gets added when they get to ordered?

# More thoughts: Make it a hash for working, then decrement each value on every pass, when it gets to zero, put the next option in?

# Set up the hash to hold the times and put the first thing into it with its timing.
working = {}

working[options[0]] = timing[options.shift]

total_time = 0

puts "At step #{total_time}, #{working.length} elves are working on #{working.inspect}"

# Until every step has been put into order
until working.length == 0

	


# Go through the working hash
	working.each do |key, value|
	
# Decrement the values at each step	
		if value > 0
			working[key] = value - 1
		end

# Set up a holding pen to hold finished items if they finish at the same time
	holding_pen = []
	
# If the value is 0, put the key into a temporary and remove it from working		
		if value == 0
			holding_pen << key
			working.delete(key)
		end

# Sort the finished items into alpha order and then push them into the ordered array		
		holding_pen.sort!
		
		holding_pen.each do |item|
			ordered << item
		end
		
	end

# Remove all finished items from the blocker hash array.
	ordered.each do |item|
	
		blockers.each_value do |value|
			value.delete(item)
		end
		
	end

# Find all the items in blockers that are now unblocked and put them into the options
	blockers.each do |key, value|
	
		if value.length == 0
			options << key	
			blockers[key] = "ignore"
		end
		
	end
	
# Clean up the options array
	options.sort!.uniq!
	
	puts "The available things to be worked on are #{options.inspect}"

# Refill the working array to 5
	if working.length < 5 and !options.empty?
	
		until working.length == 5 or options.empty?
			working[options[0]] = timing[options[0]]
			options.shift
		end
		
	end
	
	puts "At step #{total_time}, #{working.length} elves are working on #{working.inspect}"

# Increment the total time to cover another step being done
	unless working.length == 0
		total_time += 1
	end
	
end

puts "The total time is:"
puts total_time