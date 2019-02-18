#/usr/bin/ruby!

info = []

char_file = File.open('day_8_input.txt')
char_file.each(" ") do |char|
		info << char.to_i
end

