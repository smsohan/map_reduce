input_files = Dir.glob('files/*.txt')

total_count = 0
pattern = /wind/

input_files.each do |input_file|
  count_in_file = File.read(input_file).scan(pattern).size

  puts "#{input_file} #{count_in_file}"

  total_count += count_in_file
end

puts total_count