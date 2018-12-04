#!/usr/bin/ruby

# Some things we need to start

input = [] # An array to hold our lines that we're about to read in

# Get the input file

f = File.open("day_3_input.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input << line
end	