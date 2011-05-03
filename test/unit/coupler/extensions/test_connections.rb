require 'helper'

module Coupler
  module Extensions
    class TestConnections < Coupler::Test::UnitTest
      def test_index
        connection = Factory(:connection)
        get "/connections"
        assert last_response.ok?
      end

      def test_new
        get "/connections/new"
        assert last_response.ok?

        doc = Nokogiri::HTML(last_response.body)
        assert_equal 1, doc.css("form[action='/connections']").length
        assert_equal 1, doc.css("select[name='connection[adapter]']").length
        %w{name host port username password}.each do |name|
          assert_equal 1, doc.css("input[name='connection[#{name}]']").length
        end
      end

      def test_successfully_creating_connection
        attribs = Factory.attributes_for(:connection)
        post "/connections", { 'connection' => attribs }
        connection = Models::Connection[:name => attribs[:name]]
        assert connection

        assert last_response.redirect?, "Wasn't redirected"
        assert_equal "http://example.org/connections", last_response['location']
      end

      def test_successfully_creating_connection_with_return_to
        attribs = Factory.attributes_for(:connection)
        post "/connections", { 'connection' => attribs }, { 'rack.session' => { :return_to => '/foo' } }

        assert last_response.redirect?, "Wasn't redirected"
        assert_equal "http://example.org/foo", last_response['location']
      end

      def test_successfully_creating_connection_with_first_use
        attribs = Factory.attributes_for(:connection)
        post "/connections", { 'connection' => attribs }, { 'rack.session' => { :first_use => true } }

        assert last_response.redirect?, "Wasn't redirected"
        assert_equal "http://example.org/projects/new", last_response['location']
      end

      def test_failing_to_create_connection
        post "/connections", {
          'connection' => Factory.attributes_for(:connection, :name => nil)
        }
        assert last_response.ok?
        assert_match /Name is not present/, last_response.body
      end

      def test_show
        connection = Factory(:connection)
        get "/connections/#{connection.id}"
        assert last_response.ok?
      end

      def test_destroy
        connection = Factory(:connection)
        delete "/connections/#{connection.id}"
        assert_nil Models::Connection[connection.id]
        assert last_response.redirect?
        assert_equal "http://example.org/connections", last_response['location']
      end
    end
  end
end
