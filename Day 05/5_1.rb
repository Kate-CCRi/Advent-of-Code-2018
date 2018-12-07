#!/usr/bin/ruby

# Get the input file
input = File.read("day_5_test.txt")

# Set up an array to read the input by character

test_answer = ["d", "a", "b", "C", "B", "A", "c", "a", "D", "A"]
polymer = input.chars
newpolymer = []


# I need to wrap this in a new iterator so that I can set polymer to the cleaned version and go over it again


	# Iterate over the array by consecutive pairs: (1,2) then (2, 3) etc.
	polymer.each_cons(2) do |x, y|

		unless x == y.upcase or x == y.downcase
		
			newpolymer << x

		end
	end
	
if newpolymer == test_answer
	puts "This is correct."
else
	puts test_answer.inspect
	puts newpolymer.inspect
end

