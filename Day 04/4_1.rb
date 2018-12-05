#!/usr/bin/ruby

# Get the input file
input = File.read("day_4_test.txt")

# Make a new array called "logs" that has the text from "input" split on the newline character (which conveniently makes that character go away). This also automatically sorts it into the proper day/time order.

logs = input.split("\n").sort

# Set up a new array called "guard_logs"
guard_logs = []

# Set up a new hash called "real_log" that is expecting arrays to go with its keys
real_log = Hash.new{|hsh, key| hsh[key] = []}

# Go through the input and put the first four items of each record into a separate array (removing the [] as you go)

logs.each do |record|
	solo_logs = record.delete("[").delete("]").split	
	solo_logs.each_slice(4) {|slice| guard_logs << slice}
end

# Iterate through the log file
guard_logs.each do |entry|

# The 4 slice causes some entries in guard_logs of ["begins", "shift"] so this checks for those and ignores them.

	if entry[0] != "begins"
		
		# This block puts the date, time, activity, and guard number (if there is one) into the appropriate variables
		date = entry[0]
		time = entry[1].delete(":")
		activity = entry[2]
		
		if entry[3].start_with?("#")
			number = entry[3].delete("#")
		else
			number = nil
		end
		
		# Use different holder variables based on whether the record is for a guard or an activity.
		if number == nil
			temp = [time, activity]	
		else
			guard_temp = [time, activity, number]
		end
		
		# This pushes whatever exists into the hash for the current date.
		if number == nil
			real_log[date].push temp
		else
			real_log[date].push guard_temp
		end
	end
end


# This block goes through the hash and pulls any shift changes from before midnight into the appropriate day.

temp_guard = []

real_log.each do |date, record|

	# This ordering is very important -- if you put the first block second, it puts the pre-midnight guard information into every record!
	
	if temp_guard.include?("Guard")
		# Puts the guard information into the record array as the *first* element.
		record.unshift(temp_guard)
		# Empties the temp_guard array now that we've placed that information.
		temp_guard = []
	end

	if record.last.include?("Guard")
		# pop pulls the last item out of an array permanently and returns that item.
		temp_guard = record.pop
	end
end



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



