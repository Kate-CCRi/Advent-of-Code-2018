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

# Put the first thing in options into ordered (while removing it from options)
ordered << options.shift

# Until all the steps have been processed
until ordered.length == steps.length

# Remove the thing most recently placed into ordered from the blockers
	blockers.each_value do |value|
	
		value.delete(ordered[-1])
		
	end

# Put all the unblocked options into the options array
	blockers.each do |key, value|
	
		if value.length == 0
		
			options << key
			
		end
		
	end

# Unique the options array and then sort it alphabetically	
	options.sort!.uniq!	

# Put the first thing in options into ordered while removing it from options	
	ordered << options.shift

# Make all the empty blockers go to "ignore" so they won't get caught by the first "if" statement in this "do" loop	
	blockers[ordered[-1]] << "ignore"

end

# Print the ordered array as one "word"
puts ordered.join