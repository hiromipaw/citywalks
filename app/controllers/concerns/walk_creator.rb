module WalkLocator
  extend ActiveSupport::Concern

  def initialize_walk
    @walk = Walk.new(:pins => "")
  end

  def pins_by_point(point)
    @pins = Walk.request_pins(point)
  end

  def pins_by_ip(ip)
    block = Walk.request_block(ip).doc["ip_block"]
    if block
      longitude = block["ip_block"]["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[0]
      latitude = ["ip_block"]["point"].scan(/\(([^\)]+)\)/).last.first.split(" ")[1]
      Walk.request_pins("#{longitude},#{latitude}")
    end
  end

  def locate_pins(params)
    if params[:point]
      @pins = pins_by_point(params[:point])
    else
      @pins = pins_by_ip(request.remote_ip)
    end
  end

end