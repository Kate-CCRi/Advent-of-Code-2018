#!/usr/bin/ruby

# Some things we need to start

current_num = 0 # A variable to hold our current number
num_array = [] # An array to hold our numbers that we're about to read in
comp_array = [] # An array to hold the calculated numbers for comparison

# Get the input file

f = File.open("day_1_input.txt")

# Read each line of the file and put its value into the array

while line = f.gets do

	input_num = line.to_i # Convert the read in strings into integers
	num_array << input_num # Push that number to the array
	
end

# Calculate the value of the number after each operation specified in the array

num_array.each {|x| 

	current_num = current_num + x
	comp_array << current_num}

# Find all the duplicates in the array and put one copy of them into a new array

comp_uniq = []
comp_uniq << comp_array.find_all { |x| comp_array.count(x) > 1}.uniq

# Print the first value in the new array

puts comp_uniq.first
