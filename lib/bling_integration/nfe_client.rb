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

    def generate_nfse(numero_rps, serie, api_key)
      params = {
        apikey: api_key,
        number: numero_rps,
        serie:  serie
      }
      default_request('notaservico', params: params)
    end

    def nfse(numero_rps, api_key)
      params = {
        apikey: api_key,
        number: numero_rps
      }
      default_request("notaservico/#{numero_rps}", params: params, http_method: :get)
    end
  end
end
