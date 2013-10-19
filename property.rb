# This class will be implemented from the HTML Operations and the XML Operations

class Property

  attr_accessor :address, :parcel, :price, :geocode, :distance_mean, :distance_under
  
  def initialize(parcel=0, price=0, address="empty")
    @address = address
    @parcel = parcel
    @price = price
    @geocode = nil 
    @distance_to = []
    @distance_mean = 0
    @distance_under = []
  end
  
  def add_geocode(geocode)
    @geocode = geocode
  end

  def to_s
    puts "#{@address} ::: #{@price} ::: #{@parcel}"
    puts geocode.to_s
  end


  def set_parcel(num)
    @parcel = num
  end
  
  def build_distance_to(properties)
    if @distance_to.empty?
      properties.each do |prop|
        @distance_to.push [@geocode.distance_to(prop.geocode), prop]
      end
    end
  end
  
  def distance_to_under(distance)
    if @distance_to.empty?
      puts "Build distance to first"
    else
      @distance_under = []
      @distance_to.each do |dist|
        if dist[0] <= distance
          @distance_under.push dist
        end
      end
      distance_to_mean(@distance_under)

    end
  end    
  
  def distance_to_mean(distance_under)
    @distance_mean = 0
    distance_under.each do |dist|
      @distance_mean += dist[0]
    end
    @distance_mean = @distance_mean/distance_under.size
    @distance_mean
  end
    
  def puts_distance_under()
    @distance_under.each{|dist| puts " ----------- #{dist[1].address}"}
  end  
  
  def center?
     c = true
     @distance_under.each do |dist|
       if (@distance_mean < dist[1].distance_mean)
         c = false
       end
    end
    c 
  end
  
end
