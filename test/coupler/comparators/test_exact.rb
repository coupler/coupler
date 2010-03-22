require File.dirname(__FILE__) + '/../../helper'

module Coupler
  module Comparators
    class TestExact < Test::Unit::TestCase
      def test_base_superclass
        assert_equal Base, Exact.superclass
      end

      def test_registers_itself
        assert Comparators.list.include?("exact")
      end

      def test_score_match_with_single_dataset
        dataset = stub("Dataset")
        dataset.expects(:order).with(:first_name).returns(dataset)
        records = [
          [{:id => 5, :first_name => "Harry"}],
          [{:id => 6, :first_name => "Harry"}],
          [{:id => 3, :first_name => "Ron"}],
          [{:id => 8, :first_name => "Ron"}]
        ]
        dataset.expects(:each).multiple_yields(*records)
        score_set = stub("ScoreSet")
        score_set.expects(:insert_or_update).with(:first_id => 5, :second_id => 6, :score => 100)
        score_set.expects(:insert_or_update).with(:first_id => 3, :second_id => 8, :score => 100)

        comparator = Exact.new('field_name' => 'first_name', 'key' => 'id')
        comparator.score(score_set, dataset)
      end

      def test_score_match_with_two_datasets
        dataset_1 = mock("Dataset", :count => 175)
        dataset_1.expects(:order).with(:first_name).returns(dataset_1)
        sequence_1 = sequence("dataset 1 records")
        dataset_1.expects(:limit).with(100, 0).returns(dataset_1).in_sequence(sequence_1)
        dataset_1.expects(:all).returns(Array.new(100) { |i| {:id => i+1,   :first_name => (i / 50 == 0) ? "Alan" : "Beth"} }).in_sequence(sequence_1)
        dataset_1.expects(:limit).with(100, 100).returns(dataset_1).in_sequence(sequence_1)
        dataset_1.expects(:all).returns(Array.new(75) { |i| {:id => i+101, :first_name => (i / 50 == 0) ? "Cody" : "Dana"} }).in_sequence(sequence_1)

        dataset_2 = mock("Dataset", :count => 200)
        dataset_2.expects(:order).with(:name_first).returns(dataset_2)
        sequence_2 = sequence("dataset 2 records")
        dataset_2.expects(:limit).with(100, 0).returns(dataset_2).in_sequence(sequence_2)
        dataset_2.expects(:all).returns(Array.new(100) { |i| {:leet_id => i+1,   :name_first => (i / 50 == 0) ? "Beth" : "Cody"} }).in_sequence(sequence_2)
        dataset_2.expects(:limit).with(100, 100).returns(dataset_2).in_sequence(sequence_2)
        dataset_2.expects(:all).returns(Array.new(100) { |i| {:leet_id => i+101, :name_first => (i / 50 == 0) ? "Dana" : "Eric"} }).in_sequence(sequence_2)

        results = Hash.new { |h, k| h[k] = [] }
        score_set = stub("ScoreSet")
        score_set.expects(:insert_or_update).times(6250).with do |hash|
          assert_equal 100, hash[:score]
          results[hash[:first_id]] << hash[:second_id]
        end

        comparator = Exact.new('field_name' => ['first_name', 'name_first'], 'key' => ['id', 'leet_id'])
        comparator.score(score_set, dataset_1, dataset_2)

        (1..175).each do |key_1|
          if key_1 <= 50
            assert !results.has_key?(key_1)
          else
            assert_equal 50, results[key_1].length, "Expected 50 scores for key #{key_1}"
            expected = ((key_1 - 1) / 50 - 1) * 50 + 1
            results[key_1].each do |key_2|
              assert_equal expected, key_2
              expected += 1
            end
          end
        end
      end

      # FIXME: add nil values

      def test_options
        expected = [
          {:label => "Field", :name => "field_name", :type => "text"}
        ]
        assert_equal expected, Exact::OPTIONS
      end

      #def test_matching_with_different_field_names
        #comparator = Exact.new('field_name' => ['first_name', 'name_first'])
        #assert_equal 100, comparator.score({:first_name => "Harry"}, {:name_first => "Harry"})
      #end

      #def test_null_as_nonmatch
        #comparator = Exact.new('field_name' => 'first_name')
        #assert_equal 0, comparator.score({:first_name => nil}, {:first_name => nil})
      #end
    end
  end
end
