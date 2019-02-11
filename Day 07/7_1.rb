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
	
end

options = ["a"]
ordered = []

# until ordered.length = steps.length

	todo.each do |parent, children|
	
		if ordered.empty?
		
			ordered << parent
			
			blockers.each_value do |value|
				value.delete(parent)
			end
			
			options.clear
			
			children.each do |child|
				if blockers[child].length == 0
					options << child
				end	
			end
			
			options.sort!.uniq!
			
		end
	
		if options[0] == parent
	
			ordered << parent
			options.delete(parent)
		
			blockers.each_value do |value|
				value.delete(parent)
			end
		
			children.each do |child|
				if blockers[child].length == 0
					options << child
				elsif blockers.key?(child) == false
					options << child
				end	
			end
		
			options.sort!.uniq!
		end	
	end
	
#end

p todo
p ordered
p options
p blockers
		
		
	
		