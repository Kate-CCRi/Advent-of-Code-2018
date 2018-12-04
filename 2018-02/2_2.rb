#!/usr/bin/ruby

# Some things we need to start

input = [] # An array to hold our lines that we're about to read in
words = [] # An array to hold the cleaned up input
len = 0 # A variable for the length of the input array

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

	words << letters
		
end

len = words.length

=begin
Some pseudocode

for each array currently in sorted
	pull out each other array in sorted
	compare Array 1 to Arrays 2..n placewise
	if only one place is different, return the values from each array
	otherwise continue
end
=end

words.each do |word| # Pull out each word array

i = 0 # Let's have fun with iterators!

	while i < len # While our iterator is smaller than the length of the array

		word.each_with_index do |word, index|
		
			same = 0
			different = 0
	
			word_two = words[i] # Pull another word out of the array
		
			if word[index] == word_two[index]
				same += 1
			elsif word[index] == word_two[index]
				different +=1
			end
		
			if different == 1
				puts word
				puts word_two
				break
			end
			
			i += 1 # Increment the iterator
		end
	end
end