require 'rexml/document'
require 'rexml/streamlistener'
include REXML

class Xml_Stream_Parser
  include StreamListener
  
  
  def initialize
    @properties = []
  end
  
  
  
  def tag_start(name, attributes)
    # puts name
    
    
    @field = name
    if (name == "property") 
      @property = Property.new 
      puts "HERE"
    end
    
    
    #########create new Property Object when you see "property"
    ###########when you see the key field, set variable to a symbol for that key field.
    #############then when text comes up and gets it, it will add the correct text to the correct field 
   
    
  end
  
  def text(text)
    # if (@field == "parcel_number")
      # @property.set_parcel(text.to_i)
      # #  puts @property.parcel
      # puts @property.to_s
    # end    
    
    case @field
    when "parcel_number"
      
      @property.set_parcel(text.chomp)
      #  puts @property.parcel
      puts @property.to_s
    when"address"
      @property.address = text.chomp
      puts @property.to_s
      puts "THIS IS THE OBJECT ID OF THE PROPERTY #{@property.object_id}"
    end
    
    
  end

  def tag_end(name)
    # puts name
    
    
    ###################push object to the array when you see "property"
    if (name == "property")
       # puts @property.to_s
       # @properties.push @property
    end
     
  end
  
  def get_array()
    properties
  end
  
    
  
end

