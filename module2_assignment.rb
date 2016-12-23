#Implemented solution for module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Declare getters and setters below for accessing data
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number

  #initialize method takes in 2 parameters of content and the line number
  def initialize(content, line_number)
    @content = content
    @line_number = line_number

    #* call the calculate_word_frequency() method.
    calculate_word_frequency()
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.


  def calculate_word_frequency()

    count = [] #Create array to store occurences of the word
    freq = Hash.new(0) #Hash

    #Notes: freq[word.downcase] corresponds to int value,

    #Counts the max times a single word appears
    phrase = content  #Assign content to phrase variable
    phrase.split.each do |word|
      #increment count for each word that appears, may be more than once
      freq[word.downcase] += 1
      #Push the numbers onto an arr
      count.push freq[word.downcase]
      #Each loop will assign max counted number onto highest_wf_count
      self.highest_wf_count = count.max
    end

    #Testing calls - puts freq

    #* identify the words that were used the maximum number of times and
    #  store that in the highest_wf_words attribute.
    #  Reject will remove element in the array that do not match the max number
    #  of times a word appears
    self.highest_wf_words = freq.reject { |key, hashVal| hashVal != highest_wf_count}.keys
    #Testing calls - p highest_wf_words

  end
end

#  Implement a class called Solution.
class Solution

  #Declare getters and setters below for accessing data
  attr_accessor :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  #initialize analyzers array object
  def initialize()
    @analyzers = []
  end

  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  def analyze_file()
    #Follows ruby lecture exampleson how to handle exceptions and opening files
    begin
      line_number = 1;
      #* Read the 'test.txt' file in lines
      #* Create an array of LineAnalyzers for each line in the file
      File.foreach('test.txt') do |line|
        line1 = LineAnalyzer.new(line, line_number)
        #Push to analyzers array object
        analyzers.push line1
        #increment line_number
        line_number += 1
      end

    #Exception message when the file specified to be opened is not there
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

    #Loops through each sentence
    analyzers.each do |line|
      #Loops through each word
      line.content.split.each do |word|
         #Increments when encountering words
        freq2[word.downcase] += 1
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
        #push onto count3 array
        count3.push << line
        #assign count 3 into the highest_count_words_across_lines
        self.highest_count_words_across_lines = count3
      end
    end

  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines()
    #prints initial message once
    puts "The following words have the highest word frequency per line:\n"
    array = []
    array = highest_count_words_across_lines

    #Loop and print words that appear the maximum number of times and attach the line number as well
    array.each do |highest|
      puts "#{elements.highest_wf_words} (appears in line #{elements.line_number})"
    end

  end

end

#Testing Calls
#line1 = LineAnalyzer.new("hello hello hello you you you me", 2)
#Solution.new.print_highest_word_frequency_across_lines()
