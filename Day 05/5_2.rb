#!/usr/bin/ruby

# Get the input file
input = File.read("day_5_input.txt")

# Set up an array to read the input by character and a variable that has its length
polymer = input.chars
shortest = polymer.length

# Push the entire alphabet into an array
alphabet = ('a'..'z').to_a


# For each letter in the alphabet array
alphabet.each do |letter|

# Make a copy of the original polymer
	working = polymer.map(&:clone)

# Make a new array that deletes the letter and its uppercase version from the polymer	
	working2 = working.delete_if{ |item| item == letter or item == letter.swapcase}
	

# This is the Day 1 reaction code
	i = 0

	# Start looping through
	loop do
		# Stop looping if you've reached the second-to-last character (nothing left to compare)
		break if i == working2.size - 1
		# Checks to see if the first thing is an uppercase or lowercase of the second thing
		if working2[i].swapcase == working2[i + 1]
			# If yes, delete the two things you just compared
			2.times {working2.delete_at(i)}
			# Unless you were at the first character, back up one step
			unless i == 0
				i -= 1
			end
		# If the comparison is false, move on to the next set
		else
			i += 1
		end
	end

# If the length of the reacted redacted polymer is less than the current shortest length, reset the current shortest length	
	if working2.length < shortest
		shortest = working2.length
	end

end

# Return the shortest length seen
puts shortest

