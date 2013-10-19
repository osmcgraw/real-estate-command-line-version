require_relative 'file_operations'

class HtmlOperations

  attr_reader :file_as_array

  def initialize (file_read = "MasterLists.html", type = :basic ) 
    file_name = file_read#change this if the file name changes -- later take this from user input  
    fileOps = FileOperations.new
    file = fileOps.open_file(file_name)
    
    if (type == :basic)
      file_as_array = parse_file(file)
    elsif (type == :sold)
      file_as_array = parse_file_sold(file)
    else
      file_as_array = []
      puts "Process type error. Need either :basic or :sold"
    end
    
    @file_as_array = clean_array(file_as_array)
  end
#this method pulls in a HTML file for parsing

  def parse_file(file_inputs)
    parsed_data = []
    #INITIALIZE VARIABLES
    row_number = 1
    row_content = []
    row_garbage = []
    
    #START LOOPING THROUGH FILE
    file_inputs.each_with_index do |line, index|
      
      # Testing to find the item number (1, 2 or 3 digits followed by a line break)
      test1 = /^\d{1,3}<br\/>/
      
      # Testing to find parcel number (7 digits followed by a line break)
      test2 = /^\d{7}<br\/>/       
      
      # Testing to find a minimum bid
      
      # Tis test is lookiing for 1,000.00 or 12,000.00 (or similar)
      test3 = /\$\d{1,2},\d{3}.00/
      
      #THis test is looking for 100.00 or similar
      test4 = /\$\d{3}.00/
      
      
      #This tests for the line to be the property identifier. Property identifiers in this document are sequential. 
  
      if (test1.match line) && (line[/^\d{1,3}/] == row_number.to_s)
        parsed_data.push row_content+row_garbage    #COME BACK AND FIX THIS, THIS PREVENTS THE LAST LINE 227 FROM BEING PARSED ...
        row_content = []
        row_garbage = []
   
       #Adding the data just found to the array 
        row_content.push line[/^\d{1,3}/]
          
        #This is iterating through the rows of data
        row_number += 1
        #These are our test cases
      elsif test2.match line
        row_content.push line[/^\d{7}/] 
      elsif (test3.match line)
        row_content.push line[/\$\d{1,2},\d{3}.00/]     
      elsif (test4.match line)
        row_content.push line[/\$\d{3}.00/]
      else
        row_garbage.push line.gsub('&#160;', ' ').gsub('<br/>', '')
      end    
    end 
    
    parsed_data
  end
  
  def parse_file(file_inputs)
    parsed_data = []
    #INITIALIZE VARIABLES
    row_number = 1
    row_content = []
    row_garbage = []
    
    #START LOOPING THROUGH FILE
    file_inputs.each_with_index do |line, index|
      
      # Testing to find the item number (1, 2 or 3 digits followed by a line break)
      test1 = /^\d{1,3}<br\/>/
      
      # Testing to find parcel number (7 digits followed by a line break)
      test2 = /^\d{7}<br\/>/       
      
      # Testing to find a minimum bid
      
      # Tis test is lookiing for 1,000.00 or 12,000.00 (or similar)
      test3 = /\$\d{1,2},\d{3}.00/
      
      #THis test is looking for 100.00 or similar
      test4 = /\$\d{3}.00/
      
      
      #This tests for the line to be the property identifier. Property identifiers in this document are sequential. 
  
      if (test1.match line) && (line[/^\d{1,3}/] == row_number.to_s)
        parsed_data.push row_content+row_garbage    #COME BACK AND FIX THIS, THIS PREVENTS THE LAST LINE 227 FROM BEING PARSED ...
        row_content = []
        row_garbage = []
   
       #Adding the data just found to the array 
        row_content.push line[/^\d{1,3}/]
          
        #This is iterating through the rows of data
        row_number += 1
        #These are our test cases
      elsif test2.match line
        row_content.push line[/^\d{7}/] 
      elsif (test3.match line)
        row_content.push line[/\$\d{1,2},\d{3}.00/]     
      elsif (test4.match line)
        row_content.push line[/\$\d{3}.00/]
      else
        row_garbage.push line.gsub('&#160;', ' ').gsub('<br/>', '')
      end    
    end 
    
    parsed_data
  end
  
  
  def clean_array(array)
    array2 = []
    array.each_with_index do |row, index|
      array2[index] = row.slice(0,4)
    end
    array2
  end

end
