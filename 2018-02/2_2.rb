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

# Remove the newline character from each line and push it to the words array as a string
input.each do |x|

# Chomp automatically removes newlines but doesn't do anything else without an argument	
	words << x.chomp.to_s 
			
end

len = words.length # Set the "len" variable to the length of the words array

=begin
Some pseudocode

for each array currently in sorted
	pull out each other array in sorted
	compare Array 1 to Arrays 2..n placewise
	if only one place is different, return the values from each array
	otherwise continue
end
=end

i = 0 # Let's have fun with iterators!

for i in 0..len # While our iterator is smaller than the length of the array

	words.each do |word| # For each word in the "words" array
	
		word.to_s
		word_two = words[i].to_s # Pull another word out of the array
		
		same = 0 # Set "same" to 0
		different = 0 # Set "different" to 0
		index = word.length # Set the index variable to the length of the word
			
		for j in 0..index # For each item between 0 and the value of index
		
			if word[j] == word_two[j]
				same += 1
			elsif word[j] != word_two[j]
				different +=1
			end
		end
		
		if different == 1
			puts word
			puts word_two
			break
		end
			
		i += 1 # Increment the iterator
	end
end
