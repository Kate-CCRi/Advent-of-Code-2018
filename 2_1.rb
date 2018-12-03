#!/usr/bin/ruby

# Some things we need to start

input_array = [] # An array to hold our numbers that we're about to read in
two_same = 0 # How many entries have the same letter twice?
three_same = 0 # How many entries have the same letter three times?


# Get the input file

f = File.open("day_2_test.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input_array << line
end	

input_array.each do |x|
	
	doubles = 0 # Are there doubles in this line? 0 = F, 1 = T
	triples = 0 # Are there triples in this line? 
	
	x.delete!("\n") # Remove the newline character from the string

	letters = x.chars # Create a new array out of the characters remaining in the string
	l_uniq = letters.uniq # Create a second array with the unique character list
	
# For each letter in the unique data source:	
	
	l_uniq.each do |y|

# If this line has already been counted towards the 2-letter count, end the check
		if doubles == 1 
			break
# Otherwise, set the variable that says you've already counted this one and increment the counter
		elsif letters.count(y) == 2
			doubles = 1
			two_same += 1
		end
# Same as above only for the 3-letter count
		if triples == 1
			break
		elsif (triples == 0 and letters.count(y) == 3)
			triples = 1
			three_same += 1
		end	
	end	
end

# The checksum is the product of the number of lines with 2 letters the same and the number of lines with 3 letters the same
checksum = two_same * three_same

puts "There are #{two_same} entries with 2 letters the same."
puts "There are #{three_same} entries with 3 letters the same."
puts "Your checksum is #{checksum}."