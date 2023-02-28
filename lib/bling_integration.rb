# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative 'bling_integration/http/base_client'
require_relative "bling_integration/version"

module BlingIntegration
  class Error < StandardError; end
  # Your code goes here...
end
