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

# Ugh, this comment is wrong, FIXIT
# Initializes the array to hold the Guard information - Level 1 = Guard, Level 2 = Minute, Level 3 = times seen

info = Hash.new
sleeptime = 0
gname = ""

real_log.each do |date, entry|

	entry.each do |record|
	
		time = record[0].to_i
		activity = record[1]
	
		if activity == "Guard"
			# Only set the "gname" variable if the record is for a guard coming on shift
			gname = "#{record[2]}"
			unless info.key?(gname)
				info[gname] = Array.new(60, 0)
			end
		elsif activity == "falls"
			sleeptime = time
		elsif activity == "wakes"
			waketime = time - 1
			min_array = info[gname]

			for i in sleeptime..waketime do
				min_array[i] = min_array[i] + 1	
			end
		end		
	end
end

# Set up a hash for the sleep times

sleepiest_guard = {}
sleepiest_minute = {}
sleep_frequency = {}

sguard = 0
smin = 0
sfreq = 0
stimes = 0

# Find the guard that sleeps the most and what minute they sleep the most
info.each do |gname, times|

	# This sums up all the values in the "times" array.
	sleepy = times.inject(0) {|sum, i| sum + i}
	# This pushes the total number of minutes asleep to the "sleepiest_guard" array
	sleepiest_guard[gname] = sleepy
	# This sets "sguard" to the guard number if they have the highest total number of minutes asleep
	sleepiest_guard.each {|guard, minutes| sguard = guard if minutes == sleepiest_guard.values.max}


	
	# This finds the index (i.e. minute) in which the guard was asleep most often
	minute = times.index(times.max)
	freq = times.max
	# This pushes the sleepiest minute to the "sleepiest_minute" array
	sleepiest_minute[gname] = minute
	sleep_frequency[gname] = freq
	
	# This sets "smin" to the sleepiest minute if the key is "sguard" (finds the sleepiest minute of the guard who slept the most minutes)
	sleepiest_minute.each {|key, value| smin = value if key == sguard}
	
	# This sets "stimes" to the minute with the highest number of sleep times
	sleepiest_minute.each {|key, value| stimes = value if value == sleepiest_minute.values.max}

	# This finds the guard who slept the most frequently in the same minute.
	sleep_frequency.each {|key, value| sfreq = key if value == sleep_frequency.values.max}
	
end

part1 = sguard.to_i * smin.to_i

part2 = sfreq.to_i * stimes.to_i

puts "The sleepiest guard is #{sguard}."
puts "The minute they slept the most in is #{smin}."

puts "The answer to part 1 is #{part1}."

puts "The guard who slept the most times in one minute is #{sfreq}."
puts "That minute is #{stimes}."
puts "The answer to part 2 is #{part2}."



