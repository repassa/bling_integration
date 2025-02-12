# frozen_string_literal: true

module BlingIntegration
  class Nfe
    attr_reader :token

    def initialize(token: )
      @token = token
    end

    def enviar_rps(id_rps)
      client.enviar_rps(id_rps, token: token)
    end

    def generate_rps(data)
      client.generate_rps(data, token: token)
    end

    def novo_contato(data)
      client.novo_contato(data, token: token)
    end

    def contatos(documento)
      client.contatos(documento, token: token)
    end

    def nfse(id_nota_servico)
      client.nfse(id_nota_servico, token: token)
    end

    def nfses
      client.nfses(token: token)
    end

    def consulta_nfse( 
      situacao: 0,
      data_inicial: '2025-01-01', 
      data_final: Date.current.to_s,
      pagina: 1
     )
      
     client.consulta_nfse(situacao, data_inicial, data_final, pagina, token: token)
    end

    
    private

    def request(data = {})
      xml = XmlBuilder.new.xml_for(data)
      client.send_xml(xml, token: token)
    rescue => error
      error
    end

    def client
      NfeClient.new
    end
  end
end
