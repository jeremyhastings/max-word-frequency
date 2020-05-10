class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency
    word_frequency = Hash.new(0)
    @highest_wf_count = 0
    @highest_wf_words = []
    @content.split.each do | word |
      word_frequency[word.downcase] += 1
    end
    word_frequency.each_value { | value | @highest_wf_count = value if value > @highest_wf_count }
    word_frequency.each_pair { | key, value | @highest_wf_words << key if value == @highest_wf_count }
  end
end

class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    if File.exist? 'test.txt'

      File.foreach( 'test.txt' ) do |line|
        @analyzers << line.chomp
      end
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
    (0...@analyzers.count).each do | index |
      line_analyzer = LineAnalyzer.new(@analyzers[index], index)
      @highest_count_across_lines = line_analyzer.highest_wf_count if line_analyzer.highest_wf_count > @highest_count_across_lines
    end
    (0...@analyzers.count).each do | index |
      line_analyzer = LineAnalyzer.new(@analyzers[index], index)
      @highest_count_words_across_lines << line_analyzer if line_analyzer.highest_wf_count == @highest_count_across_lines
    end
  end

  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line_analyzer|
      puts "#{line_analyzer.highest_wf_words} (appears in line #{line_analyzer.line_number})"
    end
  end
end