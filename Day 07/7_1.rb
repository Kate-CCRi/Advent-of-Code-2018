#!/usr/bin/ruby

# Read in the input file line by line

words = []

File.readlines('day_7_test.txt').each do |line|
	words << line.split(" ")	
end

# Create hashes to keep the steps in.

ordered = Hash.new { |hash, key| hash[key] = []}
blockers = Hash.new { |hash, key| hash[key] = []}

# Make an array for all the names of the steps so you can iterate with it later
steps = []

# Take each line and pull out the step names in order and put them into the various hashes and arrays

words.each do |line|

	first = line[1]
	second = line[7]
	
	ordered[first] << second
	blockers[second] << first
	
	steps << first
	steps << second
	
end

# Unique the step name array
steps = steps.uniq

puts "The steps are #{steps.inspect}"

# Alphabetize the step sequences that follow each new step (note that the ! after sort is what makes this work -- otherwise sort returns a new array instead of sorting the existing one)
ordered.each do |key, value|

	key = value.sort!

end

# Reverse alphabetize the reverse traversal values (same note about the ! as above)
blockers.each do |key, value|

	key = value.sort!.reverse!

end

# Start a new array to hold the ordered steps	
orderedsteps = []

=begin

For each step
	- if it has blockers, skip it for now
	- if it doesn't
		- put its alphabetically first child into the list of things to do
		- delete that child from the list of available to-dos
		- delete this task from all blocker lists
end
	- return the entire ordered to-do list
	
=end

# while blockers.length != 0
	options = []

	steps.each do |step|
	
		puts "The current step is #{step}"

	
		first = "first"

		if orderedsteps.length == 0
		
			first = step
	
			orderedsteps << step
		
			blockers.each do |key, value|
				value.delete(step)	
			end	
		
			orderedsteps << ordered[step][0]
		
			ordered.each do |key, value|
			
				if value.length == 0
					ordered.delete(key)
				elsif key == step
					options << ordered[step]
					options.flatten!.sort!
					puts "Your options are #{options.inspect}"
					ordered[step].delete_at(0)
				end
			end
			
			blockers.each do |key, value|
				puts blockers.inspect
			
				if value.length == 0
					blockers.delete(key)
				end
				
				if options.include?(key)
					options.delete(key)
				end
			end
		end
		
		if ordered.key?(step) and options.include?(step)
			
			puts "Step #{step} is not blocked."
			
			options.delete(step)
		
			unless orderedsteps.include?(step)	
				orderedsteps << step
			end
		
			blockers.each do |key, value|
				value.delete(step)	
			end	
		
			orderedsteps << ordered[step][0]
			
			puts ordered[step][0]
			puts orderedsteps.inspect
		
			ordered.each do |key, value|

				if value.length == 0
					ordered.delete(key)
				elsif key == step
					options << ordered[step]
					options.flatten!.sort!
					puts "Your options are #{options.inspect}"
					ordered[step].delete_at(0)
				end
			end
			
			blockers.each do |key, value|
			
				if value.length == 0
					blockers.delete(key)
				end
			end
		end
		
		
	end


# end


puts orderedsteps.inspect
puts ordered.inspect
puts blockers.inspect


