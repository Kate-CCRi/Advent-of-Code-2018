#/usr/bin/ruby!

data_index = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		data_index << char.to_i
end

=begin
# Beginning of a Tree implementation

module Tree

	class Node

		attr_accessor :children, :content, :name
	
		def initialize(name, content)
			@name = name
			@children = []
			@content = content
		end
	
		def add_child(child)
			@children << child
		end
		
		def print_subtree(node)
			children = node.children.map { |child| child.content}
			puts "#{node.content}: #{children}"
		end
		
		def traverse_subtree(&block)
			node_queue = [self]
			until node_queue.empty?
				node = node_queue.shift
				yield node
				node_queue = node.children.concat(node_queue)
			end
		end
		
		def dependency_list(node)
			node.children.flat_map do |child|
				[child.content] + dependency_list(child)
			end
		end
		
	end
	
end
=end

=begin
until data_index.length == 0

	puts "The data index length is #{data_index.length}"

	child_count = data_index[0].to_i
	metadata_count = data_index[1].to_i
	
	puts "This item has #{child_count} children"
	puts "This item has #{metadata_count} pieces of metadata"
	
	if child_count == 0
	
		puts "The child count was 0"
		
		metadata_count.times do
			puts "I am about to add #{data_index[2]} to #{sum}"
			sum += data_index[2].to_i
			puts "I am about to delete #{data_index[2]}"
			data_index.delete_at(2)
		end
	
	else
		metadata_count.times do
		
			puts "I am about to add #{data_index[-1]} to #{sum}"
		
			sum += data_index.pop.to_i
		end
		
	end
	
	2.times do
		puts "I am about to remove #{data_index[0]}"
		data_index.shift
	end
end

puts sum

=end

# The idea is to set up an array [# children, # metadata, [child info], metadata entries]
data_array = []

data_array << data_index[0]
data_array << data_index[1]


	holder = []
	index_count = 2

# This sort of does the right thing, but I think maybe I need to make it 'N' times do, where N is the number of children each thing has?
	
data_index[0].times do

	unless data_index[index_count] == 0
	
		holder.clear
		
		holder << data_index[index_count]
		holder << data_index[index_count + 1]

		data_array << [holder[0], holder[1]]
		
		index_count +=2
		
	else
		holder.clear
	
		holder << data_index[index_count]
		holder << data_index[index_count + 1]

		data_array << [holder[0], holder[1]]
		
		counter = 2
		holder.clear
		
		data_index[index_count + 1].times do 
			
			holder << data_index[index_count + counter]
			
			counter += 1
		end
		
		holder.each do |item|
			data_array.last << item
		end
		
	end
end




p data_array

	