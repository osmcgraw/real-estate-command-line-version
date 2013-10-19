class TestOperations


  def put_array_to_screen_guh(array)
    array.each_with_index do |row_string, row_index|
      puts "\n\n NEW ROW \n"
      row_string.each do
        puts "\n Item Number: #{row_index.to_s} \n"
      end
    end
  end
  
  def put_array_to_screen(array)
    array.each do |x| 
      puts x[1]
    end
  end


end