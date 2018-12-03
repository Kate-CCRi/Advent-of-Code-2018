#!/usr/bin/ruby

# Some things we need to start

input = [] # An array to hold our lines that we're about to read in
sorted = []

# Get the input file

f = File.open("day_2_test_2.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input << line
end	

input.each do |x|
	
	letters = []
	
	x.delete!("\n") # Remove the newline character from the string
	
	letters = x.chars.sort # Create a new array out of the characters remaining in the string and sort them
	sorted << letters
		
end
 
sorted.sort

puts sorted


