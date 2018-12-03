#!/usr/bin/ruby

# Some things we need to start

current_num = 0 # A variable to hold our current number
num_array = [] # An array to hold our input numbers
comp_array = [] # An array to hold the calculated numbers for comparison
dup_array = []

# Get the input file

f = File.open("day_1_test.txt")

# Read each line of the file and put its value into the array

while line = f.gets do

	input_num = line.to_i # Convert the read in strings into integers
	num_array << input_num # Push that number to the array
end	

while dup_array.length == 0

	num_array.each do |x|
		current_num = current_num + x
		comp_array << current_num
	end
	
	dup_array = comp_array.select{ |x| comp_array.count(x) > 1}
end

puts dup_array.first