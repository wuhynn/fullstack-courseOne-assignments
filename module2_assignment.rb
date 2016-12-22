#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(content, line_number)
    @content = content
    @line_number = line_number

    calculate_word_frequency()
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.

  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency()

    count = [] #Create array to store occurences of the word
    wordArr =[]
    freq = Hash.new(0) #Hash

    #Notes: freq[word.downcase] corresponds to int value,

    #Counts the max times a single word appears
    phrase = content  #Assign content to phrase variable
    phrase.split.each do |word|
      freq[word.downcase] += 1

      #Push the numbers onto an arr
      count.push freq[word.downcase]
      #Each loop will assign max counted number onto highest_wf_count
      self.highest_wf_count = count.max

    end

    puts freq

    #Use highest_wf_count to help sort as per the requirement
    #Reject will remove element in the array that do not match the number of times
    #a word appears
    self.highest_wf_words = freq.reject { |key, hashVal| hashVal != highest_wf_count}.keys
    #p highest_wf_words

  end

end

#  Implement a class called Solution.
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.
  attr_accessor :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format
  def initialize()
    @analyzers = []
  end
  # Implement the analyze_file() method() to:

  def analyze_file()
    begin
      line_number = 1;
      #* Read the 'test.txt' file in lines
      #* Create an array of LineAnalyzers for each line in the file
      File.foreach('test.txt') do |line|
        line1 = LineAnalyzer.new(line, line_number)
        analyzers.push line1
        line_number += 1
      end

    rescue Exception => e
      puts e.message
      puts "Error: The file does not exist."
    end
  end

  # Implement the calculate_line_with_highest_frequency() method to:

  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.

  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency()
    freq2 = Hash.new(0)
    count2 = []
    count3 = []

    analyzers.each do |line| #Loops through each sentence
      line.content.split.each do |word| #Loops through each word
        freq2[word.downcase] += 1 #Increments when encountering words

        #Push the numbers onto an array
        count2.push freq2[word.downcase]
        #Each loop will assign max counted number onto highest_count_across_lines
        self.highest_count_across_lines = count2.max

      end
    end

    #Iterate and store the words with most occurences into an array
    analyzers.each do |line|
       #if the highest_wf_count is the same as highest_count_across_lines
      if line.highest_wf_count == highest_count_across_lines
        count3.push << line

        self.highest_count_words_across_lines = count3
      end
    end

  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines()

  end

end

#line1 = LineAnalyzer.new("hello hello hello you you you me", 2)

sol = Solution.new()
