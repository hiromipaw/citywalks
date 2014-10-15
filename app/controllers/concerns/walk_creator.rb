module WalkCreator
  extend ActiveSupport::Concern

  def initialize_walk(params)
    params[:location] = set_location(params[:location])
    params[:pins] = params[:pins].split(",")
    Walk.new(params)
  end

  def set_location(location)
    if location
      location = location.split(",")
      [location[0].to_f, location[1].to_f]
    else
      block = retrieve_position(request.remote_ip)
      if block
        longitude = block["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[0]
        latitude = block["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[1]
        [longitude.to_f, latitude.to_f ]
      end
    end
  end


  def retrieve_position(ip)
    Walk.request_block(ip).doc["ip_block"]
  end

end