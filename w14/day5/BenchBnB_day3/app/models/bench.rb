class Bench < ApplicationRecord
  def self.in_bounds(bounds) 
    # google map bounds will be in the following format:
    # {
    #   "northEast"=> {"lat"=>"37.80971", "lng"=>"-122.39208"},
    #   "southWest"=> {"lat"=>"37.74187", "lng"=>"-122.47791"}
    # }
    ne_lat = bounds["northEast"]["lat"]
    ne_lng = bounds["northEast"]["lng"]
    sw_lat = bounds["southWest"]["lat"]
    sw_lng = bounds["southWest"]["lng"]

    Bench.all.select do |bench|
      bench.lat.between(ne_lat, sw_lat) && bench.lng.between(ne_lng, sw_lng)
    end
  end
end
