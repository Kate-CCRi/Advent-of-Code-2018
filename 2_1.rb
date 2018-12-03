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

puts input_array	

input_array.each do |x|
	
	x.delete!("\n")

	letters = x.chars
	l_uniq = letters.uniq
	puts "The original array is #{letters}."
	puts "The uniqued array is #{l_uniq}."
	
	l_uniq.each do |y|
		puts y
		if letters.count(y) == 2
			doubles = 1
		elsif letters.count(y) == 3
			triples = 1
		else
		end		
		if doubles == 1
			two_same += 1
			puts "There are now #{two_same} things with 2 letters the same."
		elsif triples == 1
			three_same += 1
			puts "There are now #{three_same} items with 3 letters the same."
		end
	end
end

checksum = two_same * three_same

puts "There are #{two_same} entries with 2 letters the same."
puts "There are #{three_same} entries with 3 letters the same."
puts "Your checksum is #{checksum}."