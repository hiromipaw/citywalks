require 'net/http'
require 'json'

module Wikicat
  CAT_VERSION = '1.0'
  CAT_SERVICE_URL = 'http://0.0.0.0:3000'
  PIN_SERVICE_URL = 'http://wikipin-nopressurelabs.rhcloud.com'

  def pin_upper(pin)
    get_pin = self.class.send_request("#{PIN_SERVICE_URL}#{pin}")
    cat = get_pin.doc["pin"]
    if cat
      sub_category = cat["title"]
      request_upper_graph(sub_category).doc[sub_category]
    end
  end

  def pin_lower(pin)
    get_pin = send_request("#{PIN_SERVICE_URL}#{pin}")
    cat = get_pin.doc["pin"]
    if cat
      sub_category = cat["title"]
      request_lower_graph(sub_category).doc[sub_category]
    end
  end

  def request_upper_graph(category)
    self.class.send_request("#{CAT_SERVICE_URL}/api/v1/graph/up/#{category.gsub!(/\s/,'_')}")
  end

  def request_lower_graph(category)
    self.class.send_request("#{CAT_SERVICE_URL}/api/v1/graph/#{category.gsub!(/\s/,'_')}")
  end

end