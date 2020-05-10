## Calculate Maximum Word Frequency

The overall goal of this project is to read some text from a file and find the word or words that appear the most in a line in the file. The way we are instructed to measure "the words that appear the most" is by 

    1. finding the highest frequency word(s) in each line
    2. finding lines in the file whose "highest frequency words" 
       is the greatest value among all lines.

### Getting Started

1. Download and extract the files.

2. Install the following gem. You may already have it installed.

    ```shell
    $ gem install rspec
    $ gem install rspec-its
    ```

3. Run the rspec command from the project root directory to execute the unit tests within the spec directory.
    
    ```shell
    $ rspec
    
    Finished in 0.02748 seconds (files took 0.16322 seconds to load)
    19 examples, 0 failures
    ```

### Technical Requirements

1. Implement a class called LineAnalyzer.

    ```shell
    class LineAnalyzer
        ...
    end
    ```

2. Implement the following read-only attributes in the LineAnalyzer class.
    * highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
    * highest_wf_words - an array of words with the maximum number of occurrences (calculated)
    * content          - the string analyzed (provided)
    * line_number      - the line number analyzed (provided)
    
    ```shell
        attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
    ```

4. Add the following methods in the LineAnalyzer class.
    * initialize() - taking a line of text (content) and a line number
    * calculate_word_frequency() - calculates result and stores in attributes
    
    ```shell
    def initialize(content, line_number)
        ...
    end
    
    def calculate_word_frequency
        ...
    end
    ```
    
5. Implement the initialize() method to:
    * take in a line of text and line number
    * initialize the content and line_number attributes
    * call the calculate_word_frequency() method.
    
    ```shell
    def initialize(content, line_number)
        @content = content
        @line_number = line_number
        calculate_word_frequency
    end
    ```
6. Implement the calculate_word_frequency() method to:
    * calculate the maximum number of times a single word appears within
    provided content and store that in the highest_wf_count attribute.
    * identify the words that were used the maximum number of times and
    store that in the highest_wf_words attribute.
    
    ```shell
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
    ```
    
7. Implement a class called Solution.

    ```shell
    class Solution
        ...
    end
    ```

8. Implement the following read-only attributes in the Solution class.
    * analyzers - an array that will hold a LineAnalyzer for each line of the input text file
    * highest_count_across_lines - a number with the value of the highest frequency of a word
    * highest_count_words_across_lines - an array of LineAnalyzers with the words with the highest frequency
    
    ```shell
        attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
    ```

9. Implement the following methods in the Solution class.
    * initialize() - initialize the array that will have analyzers for each line of the file 
    * analyze_file() - processes 'test.txt' into an array of LineAnalyzers
    * calculate_line_with_highest_frequency() - determines which line(s) of
    text has the highest number of occurrence of a single word
    * print_highest_word_frequency_across_lines() - prints the word(s) with the 
    highest number of occurrences and its corresponding line number 
    ```shell
    def initialize
        ...
    end
    
    def analyze_file
        ...
    end
    
    def calculate_line_with_highest_frequency
        ...
    end
    
    def print_highest_word_frequency_across_lines
        ...
    end
    ```

10. Implement the initialize() method to:
    * initialize analyzers as an empty array
    
    ```shell
    def initialize
        @analyzers = []
    end
    ```
    
11. Implement the analyze_file() method to:
    * Read the 'test.txt' file in lines 
    * Create an array of LineAnalyzers for each line in the file
    
    ```shell
    def analyze_file
        if File.exist? 'test.txt'
        
            File.foreach( 'test.txt' ) do |line|
                @analyzers << line.chomp
            end
        end
    end
    ```

12. Implement the calculate_line_with_highest_frequency() method to:
    * calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in the analyzers array 
    and store this result in the highest_count_across_lines attribute.
    * identify the LineAnalyzer object(s) in the analyzers array that have the highest_wf_count equal to the
    highest_count_across_lines attribute value found in the previous step and store them in
    highest_count_words_across_lines attribute.
    
    ```shell
    def calculate_line_with_highest_frequency
        @highest_count_across_lines = 0
        @highest_count_words_across_lines = []
        (0...@analyzers.count).each do | index |
            line_analyzer = LineAnalyzer.new(@analyzers[index], index)
            @highest_count_across_lines = line_analyzer.highest_wf_count if line_analyzer.highest_wf_count >
            @highest_count_across_lines
        end
        (0...@analyzers.count).each do | index |
            line_analyzer = LineAnalyzer.new(@analyzers[index], index)
            @highest_count_words_across_lines << line_analyzer if line_analyzer.highest_wf_count == 
            @highest_count_across_lines
        end
    end
    ```

13. Implement the print_highest_word_frequency_across_lines() method to
    * print the result in the following format

    ```text
    The following words have the highest word frequency per line: 
    ["word1"] (appears in line #)
    ["word2", "word3"] (appears in line #)
    ```
    
    ```shell
    def print_highest_word_frequency_across_lines
        puts "The following words have the highest word frequency per line:"
        @highest_count_words_across_lines.each do |line_analyzer|
            puts "#{line_analyzer.highest_wf_words} (appears in line #{line_analyzer.line_number})"
        end
    end
 
