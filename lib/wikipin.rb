require 'net/http'
require 'json'

module Wikipin

  PIN_VERSION = '1.0'
  PIN_SERVICE_URL = 'http://wikipin-nopressurelabs.rhcloud.com/api/v1'

  def request_pins(point=nil)
    # point = "lon,lat"
    if point
      send_request("#{PIN_SERVICE_URL}/pins/?point=#{point}")
    else
      send_request("#{PIN_SERVICE_URL}/pins")
    end
  end

  def request_block(ip)
    send_request("#{PIN_SERVICE_URL}/blocks?ip_address=#{ip}")
  end

end