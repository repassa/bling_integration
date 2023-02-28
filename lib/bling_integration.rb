# frozen_string_literal: true

require_relative 'bling_integration/http/base_client'
require_relative 'bling_integration/client'
require_relative 'bling_integration/nfe_client'
require_relative 'bling_integration/version'
require_relative 'bling_integration/xml_builder'

module BlingIntegration
  class Error < StandardError; end
  # Your code goes here...
end
