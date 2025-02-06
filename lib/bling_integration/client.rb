# frozen_string_literal: true

module BlingIntegration
  class Client < Http::BaseClient
    attr_reader :base_url
    attr_accessor :response

    API_VERSION = 'v3'
    ENDPOINT    = 'https://www.bling.com.br/Api'

    private_constant :ENDPOINT, :API_VERSION

    def initialize
      super
      @base_url = "#{ENDPOINT}/#{API_VERSION}/"
    end

    def default_request(resource, params: {}, http_method: :post, token:)
      request(
        http_method: http_method,
        endpoint:    resource,
        params:      params,
        token:       token
      )
    end
  end
end
