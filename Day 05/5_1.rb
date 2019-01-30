#!/usr/bin/ruby

# Get the input file
input = File.read("day_5_test.txt")

# Set up an array to read the input by character
polymer = input.chars

# Establish an iteration counter
i = 0

# Start looping through
loop do
	# Stop looping if you've reached the second-to-last character (nothing left to compare)
	break if i == polymer.size - 1
	# Checks to see if the first thing is an uppercase or lowercase of the second thing
	if polymer[i].swapcase == polymer[i + 1]
		# If yes, delete the two things you just compared
		2.times {polymer.delete_at(i)}
		# Unless you were at the first character, back up one step
		unless i == 0
			i -= 1
		end
	# If the comparison is false, move on to the next set
	else
		i += 1
	end
end

# Print the length of the resulting polymer
puts polymer.length