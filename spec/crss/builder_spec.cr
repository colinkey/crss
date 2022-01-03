require "xml"
require "../spec_helper"

describe CRSS::Builder::Builder do
  it "extracts channel from JSON" do
    json = <<-JSON
    {
      "channel": {
        "title": "Foo",
        "description": "Bar",
        "link": "Baz"
      },
      "items": []
    }
    JSON

    builder = CRSS::Builder::Builder.new(json)
    parsed_output = XML.parse(builder.build)
    parsed_output.xpath_node("//rss/channel/title").as(XML::Node).inner_text.should eq "Foo"
    parsed_output.xpath_node("//rss/channel/description").as(XML::Node).inner_text.should eq "Bar"
    parsed_output.xpath_node("//rss/channel/link").as(XML::Node).inner_text.should eq "Baz"
  end

  it "adds generator key to channel" do
    json = <<-JSON
    {
      "channel": {
        "title": "Foo",
        "description": "Bar",
        "link": "Baz"
      },
      "items": []
    }
    JSON

    builder = CRSS::Builder::Builder.new(json)
    parsed_output = XML.parse(builder.build)
    parsed_output.xpath_node("//rss/channel/generator").as(XML::Node).inner_text.should eq "Crystal RSS - https://www.github.com/colinkey/crss"
  end

  it "raises an error if a required channel key is missing" do
    json = <<-JSON
    {
      "channel": {
        "title": "Foo",
        "description": "Bar"
      },
      "items": []
    }
    JSON

    builder = CRSS::Builder::Builder.new(json)
    expect_raises(CRSS::Exceptions::RequiredElementMissing) do
      XML.parse(builder.build)
    end
  end

  it "gets all links from json" do
    json = <<-JSON
    {
      "channel": {
        "title": "Foo",
        "description": "Bar",
        "link": "Baz"
      },
      "items": [
        { "title": "Foo", "description": "Bar" },
        { "title": "Bar", "description": "Baz" }
      ]
    }
    JSON

    builder = CRSS::Builder::Builder.new(json)
    parsed_output = XML.parse(builder.build)
    parsed_output.xpath_nodes("//rss/item").as(XML::NodeSet).size.should eq 2
  end

  it "formats items correctly" do
    json = <<-JSON
    {
      "channel": {
        "title": "Foo",
        "description": "Bar",
        "link": "Baz"
      },
      "items": [
        { "title": "Foo", "description": "Bar" },
        { "title": "Bar", "description": "Baz" }
      ]
    }
    JSON

    builder = CRSS::Builder::Builder.new(json)
    parsed_output = XML.parse(builder.build)
    parsed_output.xpath_node("//rss/item/title").as(XML::Node).inner_text.should eq "Foo"
    parsed_output.xpath_node("//rss/item/description").as(XML::Node).inner_text.should eq "Bar"
  end
end
