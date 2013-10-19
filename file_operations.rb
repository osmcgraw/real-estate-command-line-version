class FileOperations
    
  def open_file(file_name)
    file_input = []
    puts "Opening File"
    File.open(file_name, 'r') do |file|
      while line =  file.gets
        file_input.push line.chomp
      end
    end
    file_input
  end

  def new_xml_file(f_name='xml_doc.xml')
    file = File.new(f_name, 'w')
    puts "Created file: #{f_name}"
    file
  end
  
  def write_to_file(file, string_to_write)
    # File.new 
    File.open(file, 'w') {|filei| file.write string_to_write}
  end
  
  
  
  
end