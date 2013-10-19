require 'rexml/document'
include REXML
require_relative 'file_operations'


class XmlOperations

  def initialize(array)
    #create an instance of file operations
    file_operator = FileOperations.new
    
    #create new xml file (returns file)
    xml_file = new_xml_file
    puts "XML FILE: #{xml_file}"
    gets
    #write xml to document (returns String)
    xml_doc = write_xml_doc(array)
    puts "XML DOC: #{xml_doc}"
    gets
    #write to file (takes file, string)
    file_operator.write_to_file(xml_file, xml_doc)
  end


 def new_xml_file(f_name='xml_doc.xml')
    file = File.new(f_name, 'w')
    puts "Created file: #{f_name}"
    file
  end




	def write_xml_doc(array)
	  doc = Document.new
	
	#write XML Decleration on the top of the document
	  x = XMLDecl.new()
	  doc <<(x)
	
	#This is the document root
	
	  root = Element.new "property_list"
	  
	  array.each_with_index do |prop, index|
	    property = Element.new "property"
	    root <<(property)

      el_id = Element.new "id"
      el_id.text = index #b_string
      property <<(el_id)   
	   
      el_parc = Element.new "parcel_number"
      el_parc.text = prop.parcel # b_string
      property <<(el_parc)
	   
      el_min_bid = Element.new "minimum_bid"
      el_min_bid.text = prop.price
      property <<(el_min_bid)
	   
      el_address = Element.new "address"
      #THIS MUST MAKE SURE THAT THREE IS AN ADDRESS IN GEOCODE -> if not 
      el_address.text = prop.geocode.street_address
      property <<(el_address)
	   
	    #el_provider  don't know if we need this
	    
	    el_city = Element.new "city"
	    el_city.text = prop.geocode.city
	    property <<(el_city)
	    
	    el_state = Element.new "state"
	    el_state.text = prop.geocode.state
	    property <<(el_state)
	    
	    el_zip = Element.new "zip"
	    el_zip.text = prop.geocode.zip
	    property <<(el_zip)
	    
	    el_lat = Element.new "lat"
	    el_lat.text = prop.geocode.lat
	    property <<(el_lat)
	       
	    el_lon = Element.new "lon"
	    el_lon.text = prop.geocode.lng
	    property <<(el_lon)
	    
	    el_country = Element.new "country"
	    el_country.text = prop.geocode.country_code
	    property <<(el_country)
	    
	    el_success = Element.new "success"
	    el_success.text = prop.geocode.success
	    property <<(el_success)
	    
	    el_geocode = Element.new "geocode_to_s"
      el_geocode.text = prop.geocode
      property <<(el_geocode)
	
	#     el_date = Element.new "date"
	#     el_date.text = some type of date object
	
	      #end test cases     
	    # end
	   end
	  doc <<(root)
	  return_string = ""
	  doc.write(return_string, 1, false, false)
	  return_string
	end
end