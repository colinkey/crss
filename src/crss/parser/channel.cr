require "xml"

require "../macros/define_xml_property"

module CRSS
  module Parser
    class Channel
      include CRSS::Macros

      property xml : XML::Node

      define_xml_property title
      define_xml_property link
      define_xml_property description
      define_xml_property language
      define_xml_property copyright
      define_xml_property managingEditor
      define_xml_property webMaster
      define_xml_property pubDate
      define_xml_property lastBuildDate
      define_xml_property category
      define_xml_property generator
      define_xml_property docs
      define_xml_property cloud
      define_xml_property ttl
      define_xml_property image
      define_xml_property textInput
      define_xml_property skipHours
      define_xml_property skipDays

      def initialize(@xml : XML::Node)
      end

      def present
        {
          title: title,
          link: link,
          description: description,
          language: language,
          copyright: copyright,
          managingEditor: managingEditor,
          webMaster: webMaster,
          pubDate: pubDate,
          lastBuildDate: lastBuildDate,
          category: category,
          generator: generator,
          docs: docs,
          cloud: cloud,
          ttl: ttl,
          image: image,
          textInput: textInput,
          skipHours: skipHours,
          skipDays: skipDays,
        }
      end
    end
  end
end
