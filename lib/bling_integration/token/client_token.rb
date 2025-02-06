# frozen_string_literal: true

module BlingIntegration
  module Token
    class ClientToken < BlingIntegration::Http::BaseClient
      attr_reader :base_url
      attr_accessor :response

      API_VERSION = 'v3'
      ENDPOINT    = 'https://www.bling.com.br/Api'

      private_constant :ENDPOINT, :API_VERSION

      def initialize
        super
        @base_url = "#{ENDPOINT}/#{API_VERSION}/"
      end

      def refresh(token, refresh_token)
        params = "grant_type=refresh_token&refresh_token=#{refresh_token}"

        headers = { token: token }

        default_request("oauth/token", params: params, headers: headers)
      end

      private

      def default_request(resource, params: {}, http_method: :post, headers: {})
        request(
          http_method: http_method,
          endpoint:    resource,
          params:      params,
          headers:     add_default_headers(headers),
          token:       { token: headers[:token] }
        )
      end

      def add_default_headers(headers)
        { 
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Authorization' => headers[:token]
        }.merge(headers)
      end
    end
  end
end
