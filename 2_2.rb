#!/usr/bin/ruby

# Some things we need to start

input_array = [] # An array to hold our numbers that we're about to read in
two_same = 0 # How many entries have the same letter twice?
three_same = 0 # How many entries have the same letter three times?


# Get the input file

f = File.open("day_2_test_2.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input_array << line
end	