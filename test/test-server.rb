require "feedcellar/test/server"
require "faraday"
require "rexml/document"

class ServerTest < Test::Unit::TestCase
  def setup
    @server = Feedcellar::Test::Server.new(port: 20075)
    @server.start
  end

  def teardown
    @server.stop
  end

  def test_rss_version
    connection = Faraday::Connection.new(url: "http://localhost:20075")
    response = connection.get("/feed.xml")
    doc = REXML::Document.new(response.body)
    rss_version = doc.elements["rss"].attributes["version"]
    assert_equal("2.0", rss_version)
  end
end
