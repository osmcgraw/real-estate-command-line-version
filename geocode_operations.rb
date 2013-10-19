require 'geokit'

class GeocodeOperations

  
  
  # def cluster_analysis(array)
  # array2 = array
  # distance = []
    # while array.each |row|
        # distance = []
        # while array.each |test|
            # distance.push = row[5].distance_to(test[5])
#   
        # end
    # end
  # end
  
  # def output_geocode(array)
  # citystate = "Indianapolis, IN"
  # array2 = []
  # array.each_with_index do |row,global_index|
    # # puts "\n ----- Row " + global_index.to_s
    # # puts Geokit::Geocoders::YahooGeocoder.geocode "#{global_index[3]}, #{citystate}"
    # array2[global_index] = row
    # array2[global_index].push Geokit::Geocoders::YahooGeocoder.geocode "#{global_index[3]}, #{citystate}"
# 
   # end
  # array2
  # end


  def output_geocode(properties)
  citystate = "Indianapolis, IN"
   properties.each do |property|
    # puts "\n ----- Row " + global_index.to_s
    # puts Geokit::Geocoders::YahooGeocoder.geocode "#{global_index[3]}, #{citystate}"
    
    #this adds a geocode object to the property object
        property.add_geocode(Geokit::Geocoders::YahooGeocoder.geocode "#{property.address}, #{citystate}")
        
        
   end
  end
  
  def distance_first_to_others(properties)
    #get first array item
    first = properties[1]
    #cycle through the others with a distance method
    properties.each_with_index do |prop, num|
      puts "#{first.address} to: #{prop.address} #{first.geocode.distance_to(prop.geocode)}"
    end
  end

  def bounds_test(properties, distance)
  #not working correctly  
    properties.each do |prop|
    bounds = Geokit::Bounds.from_point_and_radius(properties[1].geocode, distance)
      # center = bounds.center
      # swne = bounds.to_a
      # dist1 = center.distance_to(swne[0])
      # dist2 = center.distance_to(swne[1])
      # puts "The center is #{center} and the distance to 1 is #{dist1} and the distance to 2 is #{dist2}"
      #puts "#{bounds.contains?(prop.geocode)} : contains?"
      if bounds.contains?(prop.geocode)
        puts "#{prop.address} is within #{distance} from #{properties[1].address}"
      
      else
        puts "#{prop.address} is out of bounds"
      end
      
        
    end
    
       
    
    
  end

end