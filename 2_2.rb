#!/usr/bin/ruby

# Some things we need to start

input = [] # An array to hold our lines that we're about to read in
sorted = []
len = 0

# Get the input file

f = File.open("day_2_test_2.txt")

# Read each line of the file and put its value into the array

while line = f.gets do
	input << line
end	

# Sort each item in the input list by letter
input.each do |x|
	
	letters = []
	
	x.delete!("\n") # Remove the newline character from the string
	
	letters = x.chars.sort # Create a new array out of the characters remaining in the string and sort them
	sorted << letters
	
	lcount = letters.count
	ldouble = lcount * 2
		
end


 
# Sort the overall list of things - this produces an array of arrays
sorted.sort

# How long is the sorted array?
len = sorted.length

=begin
Some pseudocode

for each array currently in sorted
	pull out each other array in sorted
	compare Array 1 to Arrays 2..n placewise
	if only one place is different, return the values from each array
	otherwise continue
end
=end

sorted.each do |x|

i = 0
xlen = x.length
dlen = xlen - 1


	while i <= len
		comp_arr = sorted.at(i)
		inter_arr = []
	
		inter_arr = x - comp_arr
		
		if inter_arr.length == dlen
			result_arr = x && comp_arr
			puts result_arr
		else
			i += 1
		end
	end
end



