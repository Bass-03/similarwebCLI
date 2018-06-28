require "similarwebCLI/version"
require "http"
require "json"

# @author Edmundo Sanchez
# @abstract a ClI to get data form the similarweb API
module SimilarwebCLI
  # User to call the Similarweb API
  class Client
    attr_accessor :apiKey
    def initialize
      raise 'There is no API key Set, please set ENV["similarwebAPI"]' if !ENV["similarwebAPI"]
      @apiKey = ENV["similarwebAPI"]
    end
    # Gets the traffic (visits) from a single website
    #
    # @param domain [String] a domain. ie: cnn.com
    # @param dStart [String] start date with format yyyy-mm or yyyy-mm-dd
    # @param dEnd [String] end date with format yyyy-mm or yyyy-mm-dddEnd
    # @param mainDomain [Boolean] true if no subdomains will be checked
    # @param granularity [String] daily,monthly,yearly
    #
    # @return [Hash] Resutls from the similar web trafic endpoint
    def traffic(domain,dStart,dEnd,mainDomain = false, granularity = "daily")
      call = HTTP.get("https://api.similarweb.com/v1/website/#{domain}/total-traffic-and-engagement/visits?api_key=#{apiKey}&start_date=#{dStart}&end_date=#{dEnd}&main_domain_only=#{mainDomain}&granularity=#{granularity}")
      return JSON.parse(call.body.to_s)
    end
  end

end
