require "xml"
require "json"
require "./builder/channel"
require "./builder/item"
require "./exceptions"

module CRSS
  module Builder
    class Builder
      alias JSONChannel = Hash(String, String)
      alias JSONItem = Hash(String, String)
      alias JSONItems = Array(JSONItem)
      alias JSONPayload = Hash(String, JSONItems | JSONChannel)

      @parsed_channel : JSONChannel
      @parsed_items : JSONItems

      def initialize(payload : String)
        parsed_payload = JSONPayload.from_json(payload)
        validate_payload(parsed_payload)

        @parsed_channel = parsed_payload["channel"].as(JSONChannel)
        @parsed_items = parsed_payload["items"].as(JSONItems)
      end

      def build
        XML.build do |xml|
          xml.element("rss") do
            xml.element("channel") do
              channel.map do |chan_hash|
                xml.element(chan_hash[:key]) { xml.text chan_hash[:value] }
              end
            end
            items.map do |item|
              xml.element("item") do
                item.map do |item_hash|
                  xml.element(item_hash[:key]) { xml.text item_hash[:value] }
                end
              end
            end
          end
        end
      end

      private def required_elements
        ["channel", "items"]
      end

      private def validate_payload(parsed_payload)
        valid = required_elements.all? do |chan_key|
          parsed_payload.has_key? chan_key
        end

        raise CRSS::Exceptions::RequiredElementMissing.new("Invalid JSON") unless valid
      end

      private def channel
        CRSS::Builder::Channel.new(@parsed_channel).build
      end

      private def items
        @parsed_items.map do |item|
          CRSS::Builder::Item.new(item).build
        end
      end
    end
  end
end
