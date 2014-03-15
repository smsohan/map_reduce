require 'json'

threads = []

pattern = /wind/

def match_finder(file_number, pattern)
  input_file = "files/words-#{file_number}.txt"
  matches = File.read(input_file).scan(pattern).size

  outfile = "mapped/#{file_number}.txt"
  IO.write(outfile, "#{input_file} #{matches}")
end

def total_match_reducer(mapped_files)
  total_count = 0

  mapped_files.each do |mapped_file|
    total_count += File.read(mapped_file).split[1].to_i
  end

  total_count
end

def max_match_reducer(mapped_files)
  file_with_max = nil
  max_count = 0

  mapped_files.each do |mapped_file|
    file, matches_in_file = File.read(mapped_file).split
    matches_in_file = matches_in_file.to_i

    if max_count < matches_in_file
      file_with_max = file
      max_count = matches_in_file
    end
  end

  [file_with_max, max_count]
end

def max_length_word_finder(file_number)
  input_file = "files/words-#{file_number}.txt"
  word_with_max_length = File.read(input_file).split.sort_by{|word| -word.length}[0]

  outfile = "mapped/#{file_number}.txt"
  IO.write(outfile, "#{input_file} #{word_with_max_length}")
end

def max_length_reducer(mapped_files)
  file_with_max = nil
  max_word = ''

  mapped_files.each do |mapped_file|
    file, word_with_max_length = File.read(mapped_file).split

    if max_word.size < word_with_max_length.size
      file_with_max = file
      max_word = word_with_max_length
    end
  end

  [file_with_max, max_word]
end

threads = []
0.upto(10).each do |file_number|
  threads << Thread.new do
    match_finder(file_number, pattern)
    # max_length_word_finder(file_number)
  end

end
threads.map(&:join)

mapped_files = Dir.glob("mapped/*.txt")
puts total_match_reducer(mapped_files)