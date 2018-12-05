#!/usr/bin/ruby

# Get the input file
input = File.read("day_4_test.txt")

# Make a new array called "logs" that has the text from "input" split on the newline character (which conveniently makes that character go away). This also automatically sorts it into the proper day/time order.

logs = input.split("\n").sort

=begin
Create a nested array like so:
[
	Day
	[
		Guard
		[
		0..59
		]
	]
]
	
If the first item in the line after the time is "Guard", go to that line in the array.
Then:
	If the first item in the next line after the time is "falls", put the minutes in that timestamp into a "marked" array.
	If the first item in the line after the time is "wakes", put (the minute - 1) in that timestamp into the "marked" array AND
	Mark the cells in the range of the "marked" array as "asleep".
=end

logs.each do |record|
	guard_logs = record.delete("[").delete("]").split
	
	guard_logs.each do |line|
		date = line[0..9]
		time = line[11..15]
		action = line[17]
		number = line[19..21]
		
		puts date
		puts time
		puts action
		puts number
	end
end