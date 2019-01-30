#!/usr/bin/ruby

# Get the input file
input = File.read("day_5_test.txt")

# Set up an array to read the input by character
polymer = input.chars


def react(array)
	# Establish an iteration counter
	i = 0

	# Start looping through
	loop do
		# Stop looping if you've reached the second-to-last character (nothing left to compare)
		break if i == array.size - 1
		# Checks to see if the first thing is an uppercase or lowercase of the second thing
		if array[i].swapcase == array[i + 1]
			# If yes, delete the two things you just compared
			2.times {array.delete_at(i)}
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
	array.length
end

=begin
Set up a "min" length counter at 0
Go through each letter of the alphabet removing it and its uppercase
React the remaining polymer
If the remaining length is < current min, set min to length
Repeat to end of alphabet
Return min
=end

shortest = polymer.length
short_polymer = []

('a'..'z').each do |char|
	polymer.each do |x|
		if x == char
			next
		elsif x == char.swapcase
			next
		else
			short_polymer << x
		end
	end
	
	short_length = react(short_polymer)
	
	if short_length < shortest
		shortest = short_length
	end
end

puts short_polymer.inspect
puts shortest
		


