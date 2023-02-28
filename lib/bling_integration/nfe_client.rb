# frozen_string_literal: true

module BlingIntegration
  class NfeClient < Client
    def send_xml(xml, api_key)
      params = {
        apikey: api_key,
        xml:    xml
      }
      default_request('notaservico', params: params)
    end
  end
end
