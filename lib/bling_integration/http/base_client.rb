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
      HTTP_OK_CODE                   = 200
      HTTP_BAD_REQUEST_CODE          = 400
      HTTP_UNAUTHORIZED_CODE         = 401
      HTTP_FORBIDDEN_CODE            = 403
      HTTP_NOT_FOUND_CODE            = 404
      HTTP_UNPROCESSABLE_ENTITY_CODE = 429

      def request(http_method:, endpoint:, params: {}, headers: {})
        @response = client.public_send(http_method, endpoint, params, add_default_headers(headers))
        return JSON.parse(@response.body) if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      private

      def client
        @client = Faraday.new(base_url) do |client|
          client.request :url_encoded
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
        response.status == HTTP_OK_CODE
      end

      def transform_keys(item)
        item.transform_keys { |i| i.underscore.to_sym }
      end
    end
  end
end
