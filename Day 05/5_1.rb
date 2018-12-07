#!/usr/bin/ruby

# Get the input file
input = File.read("day_5_test.txt")

# Set up an array to read the input by character

polymer = input.chars
newpolymer = []

# Iterate over the array in groups of two
polymer.each_slice(2) do |x, y|
	
	unless x == y.upcase or x == y.downcase
		newpolymer << x
		newpolymer << y
	end
end

puts newpolymer