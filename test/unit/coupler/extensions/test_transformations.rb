require 'helper'

module Coupler
  module Extensions
    class TestTransformations < Coupler::Test::UnitTest
      def setup
        super
        @project = Factory(:project)
        @resource = Factory(:resource, :project => @project)
        @transformer = Factory(:transformer)
      end

      def test_new
        get "/projects/#{@project.id}/resources/#{@resource.id}/transformations/new"
        assert last_response.ok?
      end

      def test_new_with_non_existant_project
        get "/projects/8675309/resources/#{@resource.id}/transformations/new"
        assert last_response.redirect?
        assert_equal "http://example.org/projects", last_response['location']
        follow_redirect!
        assert_match /The project you were looking for doesn't exist/, last_response.body
      end

      def test_new_with_non_existant_resource
        get "/projects/#{@project.id}/resources/8675309/transformations/new"
        assert last_response.redirect?
        assert_equal "http://example.org/projects/#{@project.id}/resources", last_response['location']
        follow_redirect!
        assert_match /The resource you were looking for doesn't exist/, last_response.body
      end

      def test_successfully_creating_transformation
        attribs = Factory.attributes_for(:transformation, {
          :transformer_id => @transformer.id,
          :source_field_id => @resource.fields.first.id
        })
        post("/projects/#{@project.id}/resources/#{@resource.id}/transformations", { 'transformation' => attribs })
        transformation = @resource.transformations_dataset.first
        assert transformation

        assert last_response.redirect?, "Wasn't redirected"
        follow_redirect!
        assert_equal "http://example.org/projects/#{@project.id}/resources/#{@resource.id}", last_request.url
      end

      def test_delete
        transformation = Factory(:transformation, :resource => @resource)
        delete "/projects/#{@project.id}/resources/#{@resource.id}/transformations/#{transformation.id}"
        assert_equal 0, Models::Transformation.filter(:id => transformation.id).count

        assert last_response.redirect?, "Wasn't redirected"
        follow_redirect!
        assert_equal "http://example.org/projects/#{@project.id}/resources/#{@resource.id}", last_request.url
      end

      def test_delete_with_non_existant_transformation
        delete "/projects/#{@project.id}/resources/#{@resource.id}/transformations/8675309"
        assert last_response.redirect?
        assert_equal "http://example.org/projects/#{@project.id}/resources/#{@resource.id}/transformations", last_response['location']
        follow_redirect!
        assert_match /The transformation you were looking for doesn't exist/, last_response.body
      end

      def test_for
        field = @resource.fields.first
        t12n = Factory(:transformation, :resource => @resource, :source_field => field, :transformer => @transformer)

        get "/projects/#{@project.id}/resources/#{@resource.id}/transformations/for/#{field.name}"
        assert_match /#{@transformer.name}/, last_response.body
      end

      def test_for_with_non_existant_field
        get "/projects/#{@project.id}/resources/#{@resource.id}/transformations/for/gobbledegook"
        assert last_response.ok?
        assert_equal '', last_response.body
      end

      def test_index
        field = @resource.fields.first
        t12n = Factory(:transformation, :resource => @resource, :source_field => field)
        get "/projects/#{@project.id}/resources/#{@resource.id}/transformations"
        assert last_response.ok?
      end

      def test_preview
        field = @resource.fields_dataset[:name => 'first_name']
        params = { :transformer_id => @transformer.id, :source_field_id => field.id, :result_field_id => field.id }
        post "/projects/#{@project.id}/resources/#{@resource.id}/transformations/preview", :transformation => params
        assert last_response.ok?, "OMG #{last_response.body}"
      end
    end
  end
end
