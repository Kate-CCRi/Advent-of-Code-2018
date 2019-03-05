#/usr/bin/ruby!

# Read the input file into an array as individual characters
info = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		info << char.to_i
end

# Establish a new "Node" object type to store the data you want about each item

class Node

	attr_reader :parent_index
	attr_accessor :child_count, :metadata_count, :children_by_index, :metadata
	
	def initialize(parent_index, child_count, metadata_count)
		
		@parent_index = parent_index
		@child_count = child_count
		@metadata_count = metadata_count
		@children_by_index = []
		@metadata = []
		
	end
	
end

# Make the first node

root = Node.new(nil, info.shift, info.shift)

# Set up an array to hold the nodes and push the root node to it
d_array = []
d_array << root

# Counters to hold the index of the parent and child of the node we're currently working on
parent_index_counter = 0
child_index_counter = 1

# while d_array[0].child_count > 0


30.times do

	current = child_index_counter
	parent = parent_index_counter
	

	# Make a new node
	if d_array[parent].child_count > 0
		d_array << Node.new(parent, info.shift, info.shift)
		d_array[parent].children_by_index << current
	
		d_array[parent].child_count = d_array[parent].child_count - 1
	
		parent_index_counter += 1
		child_index_counter += 1
		
	elsif d_array[parent].child_count == 0 && d_array[parent].metadata.empty?
	
		d_array[parent].metadata_count.times do
		
			d_array[parent].metadata << info.shift
		end
		
		parent_index_counter = d_array[parent].parent_index || 0
		
		next
	else 	
		parent_index_counter = d_array[parent].parent_index || 0
	end
	
	puts "The current child_index is #{child_index_counter}"
	puts "The current parent index is #{parent_index_counter}"
	puts "d_array[current] is #{d_array[current].inspect}"
	

	if d_array[current].child_count == 0
	
		d_array[current].metadata_count.times do
		
			d_array[current].metadata << info.shift
		end
		
		parent_index_counter = d_array[current].parent_index
		
		puts "The current child_index is #{child_index_counter}"
		puts "The current parent index is #{parent_index_counter}"
		
	end

end
	
p d_array
puts "The current child_index is #{child_index_counter}"
puts "The current parent index is #{parent_index_counter}"
	
=begin

- make new node
- if has children, start from top
- if not has children
	- pull metadata for array
	- reduce child count on parent
	- check parent for "if has children" condition and repeat the appropriate action
	
=end
		













