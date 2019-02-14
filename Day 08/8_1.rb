#/usr/bin/ruby!

data_index = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		data_index << char
end

sum = 0

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
	