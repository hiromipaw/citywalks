require 'net/http'
require 'json'

module Wikicat
  CAT_VERSION = '1.0'
  CAT_SERVICE_URL = 'http://0.0.0.0:3000/api/v1'

  def pin_upper(pin)
    get_pin = send_request("#{CAT_SERVICE_URL}#{pin}")
    cat = get_pin["pin"]
    if cat["pin"]
      sub_category = cat["title"]
      request_upper_graph(sub_category)[sub_category]
    end
  end

  def pin_lower(pin)
    get_pin = send_request("#{CAT_SERVICE_URL}#{pin}")
    cat = get_pin["pin"]
    if cat
      sub_category = cat["title"]
      request_lower_graph(sub_category)[sub_category]
    end
  end

  def request_upper_graph(category)
    send_request("#{CAT_SERVICE_URL}/graph/up/#{category}")
  end

  def request_lower_graph(category)
    send_request("#{CAT_SERVICE_URL}/graph/#{category}")
  end

end