#/usr/bin/ruby!

info = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		info << char.to_i
end

# Set up some counters and holders

holder = []
index_count = 2
working_on = []
level = 0
children = []
total_sum = 0

# The idea is to set up an array [# children, # metadata, [child info], metadata entries]
data_array = []

# Push the first two pieces of data into the data array
data_array << [info[0], info[1]]
children << info[1]



# This sort of does the right thing, but I think maybe I need to make it 'N' times do, where N is the number of children each thing has?
	
# until <TODO: figure out the iterator>

8.times do

	# Clear the holder
	holder.clear
		
	# Put the next two pieces of information into the holder
	holder << info[index_count]
	holder << info[index_count + 1]
	
	# Add the child count and metadata count to the data array and the children count of this item to the child_count array
	data_array << [holder[0], holder[1]]
	children << holder[1]
	
	puts "I just added #{holder.inspect}"

	unless holder[0] == 0
	
		# Add 2 to the index count so you can get to the next set of children/metadata count info
		index_count +=2
		
		# Add 1 to the level because you're one level down now
		level += 1
	
		puts "and the level is #{level}"
		
	else 
		
		# Set up a counter to increment the index count
		counter = 2
		
		# The number of times you want to add the metadata to the item
		repeat = holder[1]
		
		# Clear the holder so you can reuse it
		holder.clear
		
		# As many times as the item you just added has metadata items, add those items to the holder and then increment the counter
		repeat.times do
			holder << info[index_count + counter]
			counter += 1
		end
		
		# Put each item in the holder into the last item in the data array
		holder.each do |item|
			data_array.last << item
		end
		
		# Update the index count
		index_count = index_count + counter	
		
		# Mark the index in children that corresponds with the set of data you just processed as "done"
		children.delete_at(-1)
		children << "done"
		
		level = level - 1
	end
	
	if children[-1] == "done"
	
		children_index = children.find_index(children[-2])
		
		children[children_index].times do
		
			data_array[children_index] << info[index_count]
		
			index_count += 1
		end
		
		children.delete_at(children_index)
		children << "done"
		
	end
end

puts "You are at level #{level}"

p data_array
p working_on
p children

	