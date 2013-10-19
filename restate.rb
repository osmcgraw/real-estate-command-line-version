require_relative 'html_operations'
require_relative 'xml_operations'
require_relative 'geocode_operations'
require_relative 'property'
require_relative 'xml_stream_listener'

# require 'rubygems'
# require 'geokit'
# require 'rexml/document'
# include REXML
# 
# 
# #MAIN METHOD!
# 
# 
# 
# 
# file_inputs = open_file('MasterLists.html')
# file_parsed = parse_file(file_inputs)
# 
# file_parsed_clean = clean_array(file_parsed)
# 
# output_file = new_xml_file('Testfile.txt')
# write_to_file(output_file, file_parsed_clean)
# 
# #creates a new XML file
# #output_file = new_xml_file('MasterLists.xml')
# 
# # this is a test case
# #write_to_file(output_file, file_parsed)
# 
# #returns a XML document as a string
# #xml_document = write_xml_doc(file_parsed)
# #puts xml_document
# #writes the XML document to the file
# #write_to_file(output_file, xml_document)
# 
# 
# # put_array_to_screen(file_parsed)
# 
# geocode_array = output_geocode(file_parsed_clean)
# 
# output_file = new_xml_file('Geocode.txt')
# write_to_file(output_file, geocode_array)
# 


def menu
  puts "\n"
  puts "Menu Options:"
  puts "1) Read in new HTML file."
  puts "1S) Read in SOLD HTML file."
  puts "2) Read in existing XML file."
  puts "3) List properties. "
  puts "3P) List properties by price."
  puts "4) test case"
  puts "5) get clusters by distance"  
  puts "Enter Command or 'Q' to exit:"
end

running = true

while (running)
  menu 
  
  command = gets.chomp
  case command
   when "Q"
     running = false
   when "1"
    
     #this returns an html_file object. now we need to get the array 
     html_file = HtmlOperations.new 
      
     #make Property Objects
     properties = []
  
     html_file.file_as_array.each do |prop|
        property = Property.new(prop[1], prop[2], prop[3])
        properties.push property
     end
     
     properties.each {|prop| prop.to_s}
    
     #init the geocoder class    
     geocoders = GeocodeOperations.new
     
     #tell the geocoder to code up the property array
     geocoders.output_geocode(properties)
#          
     #write array to xml file
     XmlOperations.new(properties)
    
     
   when "1S"
     #this returns an html_file object. now we need to get the array 
     html_file = HtmlOperations.new s
      
     #make Property Objects
     properties = []
  
     html_file.file_as_array.each do |prop|
        property = Property.new(prop[1], prop[2], prop[3])
        properties.push property
     end
     
     properties.each {|prop| prop.to_s}
    
     #init the geocoder class    
     geocoders = GeocodeOperations.new
     
     #tell the geocoder to code up the property array
     geocoders.output_geocode(properties)
#          
     #write array to xml file
     XmlOperations.new(properties)
    
   when "2"
     listener = Xml_Stream_Listener.new
     parser = Parsers::StreamParser.new(File.new("xml_doc.xml"), listener)
     parser.parse
     properties = listener.get_array
   
   when "3"
       properties.each do |prop|
        prop.to_s
        gets
       end
   
   when "3P"
     properties_by_price = properties.sort {|x, y| x.price <=> y.price}
     puts "Properties Sorted By Price:"
     properties_by_price.each do |prop|
       puts "#{prop.to_s}"
       gets
     end
       
   when "4"
     geocoders = GeocodeOperations.new
     geocoders.distance_first_to_others(properties)
        
   when "5"
     puts "What radius?"
     radius = gets
     properties.each do |prop|
       prop.build_distance_to(properties)
     end
     
     properties.each do |prop|
       
       prop.distance_to_under(radius.to_i)
       
     end        
     
     properties_cluster = properties.sort {|x, y| y.distance_mean <=> x.distance_mean}
     
     properties_cluster_centers = properties_cluster.reject{|prop| !prop.center?}
          
     properties_cluster_centers.each_with_index do |prop, num| 
       puts "\n\n#{num+1}) #{prop.address}'s density value is #{prop.distance_mean} "
      prop.puts_distance_under
       
     end
     
   
   when "bt"
     geocoders = GeocodeOperations.new
     geocoders.bounds_test(properties, 2)
   
   else  
     puts "Sorry, I don't recognize that statement"
   end

end
