#!/usr/bin/ruby

# Some things we need to start

# An array to hold our lines that we're about to read in
input = []

# Get the input file
f = File.open("day_4_test.txt")

# Read each line of the file and put its value into the array
while line = f.gets do
	input << line
end