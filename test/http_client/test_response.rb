require 'helper'

class ResponseTest < Test::Unit::TestCase

  def test_response_body
    get = HTTP::Get.new("/echo?content=baz")
    response = @client.execute(get)
    assert_equal("baz", response.body)
  end

  def test_response_code
    get = HTTP::Get.new("/echo?content=baz")
    response = @client.execute(get)
    assert_equal(HTTP::Status::OK, response.status_code)
  end

  def test_post_with_query_string_and_body
    post = HTTP::Post.new("/echo?query=a_query", :jake => "sent a video")
    post.body = "the body"
    response = @client.execute(post)
    assert_equal("\"{\"query\"=>\"a_query\"}\"", response.headers['x-echoed-query'])
    assert_equal("the body", response.headers['x-echoed-body'])
  end

  def setup
    @client = HTTP::Client.new(:default_host => "http://localhost:8080")
  end

  def teardown
    @client.shutdown
  end
end