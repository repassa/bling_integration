# frozen_string_literal: true

module BlingIntegration
  class Nfe
    def initialize(options = {})
      @options = {
        api_key: ''
      }.merge(options)
    end

    def send_xml(data = {})
      request(data)
    end

    private

    def request(data = {})
      xml = XmlBuilder.new.xml_for(data)
      client.send_xml(xml, @options[:api_key])
    rescue => error
      error
    end

    def client
      NfeClient.new
    end
  end
end
