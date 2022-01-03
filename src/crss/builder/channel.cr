require "../exceptions"

module CRSS
  module Builder
    class Channel
      def initialize(@channel : CRSS::Builder::Builder::JSONChannel)
      end

      def build
        validate_channel_elements
        keys = @channel.keys.map { |k| { key: k, value: @channel[k] } }
        keys << generator_node
        keys
      end

      private def generator_node
        { key: "generator", value: "Crystal RSS - https://www.github.com/colinkey/crss" }
      end

      private def required_channels
        ["title", "link", "description"]
      end

      private def validate_channel_elements
        valid = required_channels.all? do |chan_key|
          @channel.has_key? chan_key
        end

        raise CRSS::Exceptions::RequiredElementMissing.new("Channel was missing a required element") unless valid
      end
    end
  end
end
