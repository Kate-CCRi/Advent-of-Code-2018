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

num_array.each do |x| 
	current_num = current_num + x
	comp_array << current_num
end

# Work out duplicates and put them in a different array

uniq_array = comp_array.select{|element| comp_array.count(element) > 1}.uniq

uniq_array.each do |x|
	puts x
end
	

