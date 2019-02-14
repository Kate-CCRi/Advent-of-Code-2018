#/usr/bin/ruby!

data_index = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		data_index << char.to_i
end

sum = 0

until data_index.length == 0

	child_count = data_index[0].to_i
	metadata_count = data_index[1].to_i
	
	if child_count == 0
	
		metadata_count.times do
			sum += data_index[2]
			data_index.delete_at(2)
		end
	
	else
		metadata_count.times do
			sum += data_index.pop.to_i
		end
		
	end
	
	2.times do
		data_index.shift
	end
end

puts sum
	