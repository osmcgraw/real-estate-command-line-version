require 'rexml/document'
require 'rexml/streamlistener'
include REXML


class Xml_Stream_Listener
  include StreamListener
  
  
  def initialize
    @properties = []
  end
  
  
  
  def tag_start(name, attributes)      
            
    @field = name
    if (name == "property") 
      @property = Property.new 
      @geocode = Geokit::GeoLoc.new
    end
    
    
    #########create new Property Object when you see "property"
    ###########when you see the key field, set variable to a symbol for that key field.
    #############then when text comes up and gets it, it will add the correct text to the correct field 
   
    
  end
  
  def text(text)
     text = text.strip
     if !text.empty? 
       case @field
       when "parcel_number"
         @property.parcel = text.to_i
       when "minimum_bid"
         @property.price = text.gsub(/[\,$]/, "").to_f
       when "address"
         @property.address = text
         @geocode.street_address = text
       when "city"
         @geocode.city = text
       when "state"
         @geocode.state = text
       when "zip"
         @geocode.zip = text
       when "lat"
         @geocode.lat = text
       when "lon"
         @geocode.lng = text
       when "country"
         @geocode.country_code = text
       when "success"
         @geocode.success = text
       else 
         puts "Found Other Text #{text}"
       end
    end
  end

  def tag_end(name)
    
    
    ###################push object to the array when you see "property"
    if (name == "property")
      @property.geocode = @geocode
      @properties.push @property
    end
  end
  
  def get_array()
    @properties
  end
  
    
  
end

