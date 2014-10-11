require 'net/http'
require 'json'

module Wikicat
  VERSION = '1.0'
  SERVICE_URL = 'http://0.0.0.0:3000/api/v1/'

  def request_upper_graph(category)
    send_request("graph/up/#{category}")
  end

  def request_lower_graph(category)
    send_request("graph#{category}")
  end

  def send_request(end_point)
    request_url = SERVICE_URL+end_point
    log "Request URL: #{request_url}"
    res = Net::HTTP.get_response(URI::parse(request_url))
    unless res.kind_of? Net::HTTPSuccess
      raise Categories::RequestError, "HTTP Response: #{res.code} #{res.message}"
    end
    Response.new(res.body)
  end

  class RequestError < StandardError; end

  # Response object returned after a REST call to service.
  class Response

    def initialize(json)
      @doc = JSON.parse(json)
    end

    # Return JSON object.
    def doc
      @doc
    end

    # Return true if response has an error.
    def has_error?
      !(error.nil? || error.empty?)
    end

    # Return error message.
    def error
      @doc.has_key? "error"
    end

    # Return error code
    def error_code
      if @doc.has_key? "error"
        @doc["error"]["status"]
      end
    end

  end

  protected

  def log(s)
    if defined? RAILS_DEFAULT_LOGGER
      RAILS_DEFAULT_LOGGER.error(s)
    elsif defined? LOGGER
      LOGGER.error(s)
    else
      puts s
    end
  end

end