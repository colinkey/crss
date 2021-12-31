module CRSS
  module Macros
    macro define_xml_property(property_name)
      def {{ property_name }}
        node = @xml.xpath_node("{{property_name}}")
        if node.nil?
          ""
        else
          node.inner_text
        end
      end
    end
  end
end
