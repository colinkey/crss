require "xml"
require "./parser/channel"
require "./parser/item"
require "./exceptions"

module CRSS
  module Parser
    class Parser
      def initialize(xml : String)
        @xml = XML.parse(xml)
      end

      def parse
        {
          channel: channel.present,
          items: items.map { |i| i.present }
        }
      end

      def channel
        @channel ||= CRSS::Channel.new(channel_node)
      end

      def channel_node
        node = @xml.xpath_node("//rss/channel")
        raise CRSS::Exceptions::NodeNotFound.new("Unable to find channel node") if node.nil?
        node
      end

      def items
        @items ||= item_objects.as(Array(CRSS::Item))
      end

      def item_objects
        objs = [] of CRSS::Item
        item_nodes.each do |node|
          objs << CRSS::Item.new(node)
        end
        objs
      end

      def item_nodes
        nodes = @xml.xpath_nodes("//rss/channel/item")
        raise CRSS::Exceptions::NodeNotFound.new("Unable to find item nodes") if nodes.nil? || nodes.empty?
        nodes
      end
    end
  end
end
