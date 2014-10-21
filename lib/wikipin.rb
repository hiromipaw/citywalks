require 'net/http'
require 'json'

module Wikipin

  PIN_VERSION = '1.0'
  PIN_SERVICE_URL = 'http://wikipin-nopressurelabs.rhcloud.com'

  def request_pins(point=nil)
    # point = "lon,lat"
    if point
      send_request("#{PIN_SERVICE_URL}/api/v1/pins/?point=#{point}")
    else
      send_request("#{PIN_SERVICE_URL}/api/v1/pins")
    end
  end

  def request_block(ip)
    send_request("#{PIN_SERVICE_URL}/api/v1/blocks?ip_address=#{ip}")
  end

  def get_pin(pin)
    send_request("#{PIN_SERVICE_URL}#{pin}")
  end

end