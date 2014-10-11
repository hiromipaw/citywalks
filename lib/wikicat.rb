require 'net/http'
require 'json'

module Wikicat
  CAT_VERSION = '1.0'
  CAT_SERVICE_URL = 'http://0.0.0.0:3000/api/v1'

  def request_upper_graph(category)
    send_request("#{CAT_SERVICE_URL}/graph/up/#{category}")
  end

  def request_lower_graph(category)
    send_request("#{CAT_SERVICE_URL}/graph/#{category}")
  end

end