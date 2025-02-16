# frozen_string_literal: true

module BlingIntegration
  module Http
    class BaseClient
      #== EXCEPTIONS ===========================================
      APIExceptionError        = Class.new(StandardError)
      BadRequestError          = Class.new(APIExceptionError)
      UnauthorizedError        = Class.new(APIExceptionError)
      ForbiddenError           = Class.new(APIExceptionError)
      NotFoundError            = Class.new(APIExceptionError)
      GenericApiError          = Class.new(APIExceptionError)
      UnprocessableEntityError = Class.new(APIExceptionError)

      #== STATUS CODE ==========================================
      HTTP_OK_CODE                   = [200, 201].freeze
      HTTP_BAD_REQUEST_CODE          = 400
      HTTP_UNAUTHORIZED_CODE         = 401
      HTTP_FORBIDDEN_CODE            = 403
      HTTP_NOT_FOUND_CODE            = 404
      HTTP_UNPROCESSABLE_ENTITY_CODE = 429

      def request(http_method:, endpoint:, params: {}, headers: {}, token: {})
        @token = token[:token]


        @response = client.public_send(http_method, endpoint, params, add_default_headers(headers)) do |req|
          unless [:get, :delete].include?(http_method)
            params = params.to_json if params.class == Hash
            req.body = params
          end
        end

        return JSON.parse(@response.body) if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      private

      def client
        @client = Faraday.new(base_url) do |client|
          client.request :authorization, :bearer, @token
          client.adapter Faraday.default_adapter
        end
      end

      def add_default_headers(headers)
        { 'Content-Type' => 'application/json' }.merge(headers)
      end

      def error_class
        case response.status
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          ForbiddenError
        when HTTP_NOT_FOUND_CODE
          NotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        else
          GenericApiError
        end
      end

      def response_successful?
        HTTP_OK_CODE.include?(response.status)
      end

      def transform_keys(item)
        item.transform_keys { |i| i.underscore.to_sym }
      end
    end
  end
end
