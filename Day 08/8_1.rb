#/usr/bin/ruby!

info = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		info << char.to_i
end

total_sum = 0

# The idea is to set up an array [# children, # metadata, [child info], metadata entries]
data_array = []

# Push the first two pieces of data into the data array
data_array << info[0]
data_array << info[1]

# Set up some counters and holders

holder = []
index_count = 2
level = 100
working_on = []

# This sort of does the right thing, but I think maybe I need to make it 'N' times do, where N is the number of children each thing has?
	
until level == 0

	# All of these have children because the first number isn't 0
	
		if level == 100
			level = 0
		end
		
		# Clear the holder
		holder.clear
		
		# Put the next two pieces of information into the holder
		holder << info[index_count]
		holder << info[index_count + 1]

		# Push this information into the data array as a sub-array
		data_array << [holder[0], holder[1]]
		
		
	if info[index_count] != 0
		# Add 2 to the index count so you can get to the next set of children/metadata count info
		index_count +=2
		
		# Add 1 to the level because you're one level down now
		level += 1
		
	else
		counter = 0
		index_count = index_count + 2
		
		info[index_count - 1].times do 
	
			total_sum += info[index_count + counter]
			
			counter += 1
			
		end
		
		
		
		index_count = index_count + counter
	
		working_on = data_array.pop
	
		if working_on[0] == working_on.length - 2
		
			working_on[1].times do
				total_sum += info[index_count]
				index_count += 1
			end

		data_array.last << [working_on[0], working_on[1]]
		level -= 1
		
		working_on.clear
		
		end
	end
	


		
end

puts total_sum
puts level

p data_array
p working_on

	