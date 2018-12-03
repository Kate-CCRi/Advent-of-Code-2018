#!/usr/bin/ruby

# Some things we need to start

input_array = [] # An array to hold our numbers that we're about to read in
ID2 = 0 # How many entries have the same letter twice?
ID3 = 0 # How many entries have the same letter three times?

# Get the input file

f = File.open("day_2_test.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input_array << line.to_s
end

input_array.each do |x|

	letters = x.chars
	
end
