# frozen_string_literal: true

module BlingIntegration
  class NfeClient < Client
    def enviar_rps(id_rps, token)
      default_request("nfse/#{id_rps}/enviar", token: token)
    end

    def generate_rps(data, token)
      default_request('nfse', params: data, token: token)
    end

    def novo_contato(data, token)
      default_request('contatos', params: data, token: token)
    end

    def contatos(documento, token)
      params = {
        numeroDocumento: documento
      }

      default_request('contatos', http_method: :get, params: params, token: token)
    end

    def nfse(id_nota_servico, token)
      default_request("nfse/#{id_nota_servico}", http_method: :get, token: token)
    end

    def nfses(token)
      default_request('nfse', http_method: :get, token: token)
    end

    def consulta_nfse(situacao, data_inicial, data_final, pagina, token)
      params = {
        situacao: situacao,
        dataEmissaoInicial: data_inicial,
        dataEmissaoFinal:   data_final,
        pagina: pagina
      }

      default_request('nfse', http_method: :get, token: token, params: params)
    end
  end
end
