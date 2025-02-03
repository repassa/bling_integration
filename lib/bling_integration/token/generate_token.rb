# frozen_string_literal: true

module BlingIntegration
  module Token
    class GenerateToken
      attr_reader :token, :refresh_token

      def initialize(token:, refresh_token:)
        @token  = token
        @refresh_token = refresh_token
      end

      def refresh
        client.refresh(token, refresh_token)
      end

      private

      def client
        ClientToken.new
      end
    end
  end
end
