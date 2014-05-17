require 'json'
require 'open-uri'

module Chiketto
  class Resource
    include Chiketto::AttrDSL

    attr_reader :id

    def initialize(args)
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.get(uri)
      uri = endpoint uri
      resource = open uri
      JSON.parse resource.read
    end

    private

    def self.endpoint(uri)
      ENDPOINT + uri + token
    end

    def self.token
      "?token=#{ENV['EVENTBRITE_API_TOKEN']}"
    end
  end
end