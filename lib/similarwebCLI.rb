require "similarwebCLI/version"
require "http"
require "json"

module SimilarwebCLI
  # User to call the Similarweb API
  class Client
    attr_accessor :apiKey
    def initialize
      raise 'There is no API key Set, please set ENV["similarwebAPI"]' if !ENV["similarwebAPI"]
      @apiKey = ENV["similarwebAPI"]
    end
    # Calls the Rank API
    def traffic(domain,dStart,dEnd,mainDomain = false, granularity = "daily")
      call = HTTP.get("https://api.similarweb.com/v1/website/#{domain}/total-traffic-and-engagement/visits?api_key=#{apiKey}&start_date=#{dStart}&end_date=#{dEnd}&main_domain_only=#{mainDomain}&granularity=#{granularity}")
      return JSON.parse(call.body.to_s)
    end
  end

end
