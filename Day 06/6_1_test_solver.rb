#!/usr/bin/env ruby

data = File.read('day_6_input.txt').chomp.split("\n").map.with_index do |d, i|
  [i, d.match(/(\d+), (\d+)/)[1..2].map(&:to_i)]
end

grid_size = 1000
grid = Array.new(grid_size) { Array.new(grid_size) }
grid_size.times do |i|
  grid_size.times do |j|
    dists = data.map { |id, coords| [id, (coords[0] - i).abs + (coords[1] - j).abs] }
    closest = dists.min_by { |_, dist| dist }
    grid[j][i] = closest[0] if dists.map{ |d| d[1] }.count(closest[1]) == 1
  end
end

edge_values = [grid[0], grid[grid_size - 1]]
edge_values << [grid.map { |r| r[0] }, grid.map { |r| r[grid_size - 1] }]
infinites = edge_values.flatten.compact

flat = grid.flatten.compact.reject { |e| infinites.include? e }
freq = flat.inject(Hash.new(0)) { |h, v| h[v] += 1; h }
most_id = flat.max_by { |v| freq[v] }
puts flat.count(most_id)