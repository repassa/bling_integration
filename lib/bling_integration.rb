# frozen_string_literal: true

require 'amazing_print'
require 'byebug'
require 'faraday'
require 'json'
require 'nokogiri'

require_relative 'bling_integration/http/base_client'
require_relative 'bling_integration/client'
require_relative 'bling_integration/nfe_client'
require_relative 'bling_integration/nfe'
require_relative 'bling_integration/version'
require_relative 'bling_integration/xml_builder'
require_relative 'bling_integration/token/client_token'
require_relative 'bling_integration/token/generate_token'

module BlingIntegration
  class Error < StandardError; end
  # Your code goes here...
end
