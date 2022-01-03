require "../exceptions"

module CRSS
  module Builder
    class Item
      def initialize(@item : CRSS::Builder::Builder::JSONItem)
      end

      def build
        validate_required_elements
        @item.keys.map { |k| { key: k, value: @item[k] } }
      end

      private def required_elements
        ["title", "description"]
      end

      private def validate_required_elements
        valid = required_elements.all? do |key|
          @item.has_key? key
        end

        raise CRSS::Exceptions::RequiredElementMissing.new("Item was missing a required element") unless valid
      end
    end
  end
end
