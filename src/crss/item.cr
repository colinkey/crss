require "xml"

require "./macros/define_xml_property"

module CRSS
  class Item
    include CRSS::Macros

    property xml : XML::Node

    def initialize(@xml : XML::Node)
    end

    def present
      {
        title: title,
        link: link,
        description: description,
        author: author,
        category: category,
        comments: comments,
        enclosure: enclosure,
        guid: guid,
        pubDate: pubDate,
        source: source
      }
    end


    define_xml_property title
    define_xml_property link
    define_xml_property description
    define_xml_property author
    define_xml_property category
    define_xml_property comments
    define_xml_property enclosure
    define_xml_property guid
    define_xml_property pubDate
    define_xml_property source
  end
end
