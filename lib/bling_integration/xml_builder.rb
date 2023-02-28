# frozen_string_literal: true

module BlingIntegration
  class XmlBuilder
    def xml_for(data)
      xml(data).to_xml.gsub(/\n/, '')
    end

    private

    def xml(data)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.send(:pedido) do
          add_info_order(xml, data)
          add_client(xml, data)
          add_services(xml, data)
        end
      end

      Nokogiri::XML(builder.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::AS_XML |
        Nokogiri::XML::Node::SaveOptions::NO_DECLARATION))
    end

    def add_info_order(xml, data)
      data[:pedido].each do |key, value|
        xml.send(key.to_sym, value)
      end
    end

    def add_client(xml, data)
      xml.send(:cliente) do
        data[:cliente].each do |key, value|
          xml.send(key.to_sym, value)
        end
      end
    end

    def add_services(xml, data)
      xml.send(:servicos) do
        data[:servicos].each do |servico|
          xml.send(:servico) do
            servico.each do |key, value|
              xml.send(key.to_sym, value)
            end
          end
        end
      end
    end
  end
end
