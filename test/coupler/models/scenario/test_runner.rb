require File.dirname(__FILE__) + '/../../../helper'

module Coupler
  module Models
    class Scenario
      class TestRunner < Test::Unit::TestCase
        @@datasets_created = false

        def setup
          super
          # set up test datasets
          if !@@datasets_created
            Sequel.connect(Config.connection_string('ruby_runner_test', :create_database => true)) do |db|
              db.create_table!(:resource_1) do
                primary_key :id
                String :ssn, :index => true
                String :dob, :index => true
                Integer :foo, :index => true
                Integer :bar, :index => true
                Integer :age, :index => true
                Integer :height, :index => true
                index [:id, :ssn]
                index [:id, :ssn, :dob]
                index [:id, :foo, :bar]
                index [:id, :age]
              end
              rows = Array.new(11000) do |i|
                [
                  i < 10500 ? "1234567%02d"  % (i / 350) : "9876%05d" % i,
                  i < 10500 ? "2000-01-%02d" % (i / 525) : nil,
                  i < 1000 ? ((x = i / 125) == 2 ? 123 : x) : nil,
                  i < 1000 ? i % 10 : nil,
                  i % 20 + 25,
                  i % 50 + 125,
                ]
              end
              db[:resource_1].import([:ssn, :dob, :foo, :bar, :age, :height], rows)

              db.create_table!(:resource_2) do
                primary_key :id
                String :SocialSecurityNumber
                index [:id, :SocialSecurityNumber]
              end
              rows = Array.new(21000) do |i|
                [
                  i < 10500 ? "1234567%02d" % (i % 30) : "9876%05d" % i,
                ]
              end
              db[:resource_2].import([:SocialSecurityNumber], rows)
            end
            @@datasets_created = true
          end
          @connection = Factory(:connection)
          @project = Factory(:project)
          @resource_1 = Factory(:resource, :database_name => "ruby_runner_test", :table_name => "resource_1", :connection => @connection, :project => @project)
          @resource_2 = Factory(:resource, :database_name => "ruby_runner_test", :table_name => "resource_2", :connection => @connection, :project => @project)
        end

        def test_self_linkage_with_one_comparison
          scenario = Factory(:scenario, :resource_1 => @resource_1, :project => @project)
          field = @resource_1.fields_dataset[:name => 'ssn']
          matcher = Factory(:matcher, {
            :scenario => scenario, :comparisons_attributes => [{
              'lhs_type' => 'field', 'lhs_value' => field.id, 'lhs_which' => 1,
              'rhs_type' => 'field', 'rhs_value' => field.id, 'rhs_which' => 2,
              'operator' => 'equals'
            }]
          })
          runner = Runner.new(scenario)
          runner.run!

          groups = {}
          scenario.local_database do |db|
            assert db.tables.include?(:groups_records_1)
            ds = db[:groups_records_1]
            assert_equal 10500, ds.count
            counts = ds.group_and_count(:group_id).all
            assert_equal 30, counts.length
            assert counts.all? { |g| g[:count] == 350 }
            assert ds.group_and_count(:record_id).all? { |r| r[:count] == 1 }
            ds.each do |row|
              record_id = groups[row[:group_id]]
              if record_id
                assert_equal (record_id - 1) / 350, (row[:record_id].to_i - 1) / 350, "Record #{row[:record_id]} should not have been in the same group as Record #{record_id}."
              else
                groups[row[:group_id]] = row[:record_id].to_i
              end
              assert_equal @resource_1.id, row[:resource_id]
            end
          end
        end

        def test_self_linkage_with_two_comparisons
          scenario = Factory(:scenario, :resource_1 => @resource_1, :project => @project)
          field_1 = @resource_1.fields_dataset[:name => 'ssn']
          field_2 = @resource_1.fields_dataset[:name => 'dob']
          matcher = Factory(:matcher, {
            :scenario => scenario, :comparisons_attributes => [
              {
                'lhs_type' => 'field', 'lhs_value' => field_1.id, 'lhs_which' => 1,
                'rhs_type' => 'field', 'rhs_value' => field_1.id, 'rhs_which' => 2,
                'operator' => 'equals'
              },
              {
                'lhs_type' => 'field', 'lhs_value' => field_2.id, 'lhs_which' => 1,
                'rhs_type' => 'field', 'rhs_value' => field_2.id, 'rhs_which' => 2,
                'operator' => 'equals'
              },
            ]
          })
          runner = Runner.new(scenario)
          runner.run!

          groups = {}
          scenario.local_database do |db|
            assert db.tables.include?(:groups_records_1)
            ds = db[:groups_records_1]
            assert_equal 10500, ds.count

            counts = ds.group_and_count(:group_id)
            assert_equal 20, counts.having(:count => 175).count
            assert_equal 20, counts.having(:count => 350).count
            assert ds.group_and_count(:record_id).all? { |r| r[:count] == 1 }
            ds.each do |row|
              record_id = groups[row[:group_id]]
              if record_id
                assert_equal (record_id - 1) / 350, (row[:record_id].to_i - 1) / 350, "Record #{row[:record_id]} should not have been in the same group as Record #{record_id}."
                assert_equal (record_id - 1) / 525, (row[:record_id].to_i - 1) / 525, "Record #{row[:record_id]} should not have been in the same group as Record #{record_id}."
              else
                groups[row[:group_id]] = row[:record_id].to_i
              end
              assert_equal @resource_1.id, row[:resource_id]
            end
          end
        end

        def test_self_linkage_with_cross_match
          scenario = Factory(:scenario, :resource_1 => @resource_1, :project => @project)
          field_1 = @resource_1.fields_dataset[:name => 'foo']
          field_2 = @resource_1.fields_dataset[:name => 'bar']
          matcher = Factory(:matcher, {
            :scenario => scenario, :comparisons_attributes => [
              {
                'lhs_type' => 'field', 'lhs_value' => field_1.id, 'lhs_which' => 1,
                'rhs_type' => 'field', 'rhs_value' => field_2.id, 'rhs_which' => 2,
                'operator' => 'equals'
              },
            ]
          })
          runner = Runner.new(scenario)
          runner.run!

          groups = {}
          scenario.local_database do |db|
            assert db.tables.include?(:groups_records_1)
            join_ds = db[:groups_records_1]
            # Breakdown of groups_records_1
            # - Values that should match each other: 0, 1, 3, 4, 5, 6, 7
            # - For each value, there are 125 records that should match in foo
            #   Total: 875
            # - For each value, there are 100 records that should match in bar
            #   Total: 700
            # * Subtotal: 1575
            # - There are 88 records where foo == bar, so each of these will
            #   have a duplicate record in the resulting table.
            # * Expected Total: 1575 - 88 = 1487
            assert_equal 1487, join_ds.count

            assert db.tables.include?(:groups_1)
            group_ds = db[:groups_1]
            assert_equal 7, group_ds.count
            group_ds.each do |group_row|
              counts = join_ds.filter(:group_id => group_row[:id]).group_and_count(:resource_id).to_hash(:resource_id, :count)
              assert_equal counts[@resource_1.id], group_row[:"resource_#{@resource_1.id}_count"]
            end

            assert_equal 0, join_ds.group_and_count(:group_id).having(:count => 1).count
          end
        end

        def test_self_linkage_with_blocking
          scenario = Factory(:scenario, :resource_1 => @resource_1, :project => @project)
          field_1 = @resource_1.fields_dataset[:name => 'age']
          field_2 = @resource_1.fields_dataset[:name => 'height']
          matcher = Factory(:matcher, {
            :scenario => scenario, :comparisons_attributes => [
              {
                'lhs_type' => 'field', 'lhs_value' => field_1.id, 'lhs_which' => 1,
                'rhs_type' => 'field', 'rhs_value' => field_1.id, 'rhs_which' => 2,
                'operator' => 'equals'
              },
              {
                'lhs_type' => 'field', 'lhs_value' => field_1.id, 'lhs_which' => 1,
                'rhs_type' => 'integer', 'rhs_value' => 30,
                'operator' => 'greater_than'
              },
              {
                'lhs_type' => 'field', 'lhs_value' => field_2.id, 'lhs_which' => 1,
                'rhs_type' => 'integer', 'rhs_value' => 150,
                'operator' => 'greater_than'
              },
            ]
          })
          runner = Runner.new(scenario)
          runner.run!

          groups = {}
          scenario.local_database do |db|
            assert db.tables.include?(:groups_records_1)
            ds = db[:groups_records_1]
            assert ds.group_and_count(:record_id).all? { |r| r[:count] == 1 }
            ds.each do |row|
              index = row[:record_id].to_i - 1
              assert index % 20 > 5,  "#{row[:record_id]}'s age is too small"
              assert index % 50 > 25, "#{row[:record_id]}'s height is too small"

              record_id = groups[row[:group_id]]
              if record_id
                assert_equal (record_id - 1) % 20 + 25, (row[:record_id].to_i - 1) % 20 + 25, "Record #{row[:record_id]} should not have been in the same group as Record #{record_id}."
              else
                groups[row[:group_id]] = row[:record_id].to_i
              end
              assert_equal @resource_1.id, row[:resource_id]
            end
          end
        end

        def test_dual_linkage_with_one_comparison
          scenario = Factory(:scenario, :resource_1 => @resource_1, :resource_2 => @resource_2, :project => @project)
          field_1 = @resource_1.fields_dataset[:name => 'ssn']
          field_2 = @resource_2.fields_dataset[:name => 'SocialSecurityNumber']
          matcher = Factory(:matcher, {
            :scenario => scenario, :comparisons_attributes => [{
              'lhs_type' => 'field', 'lhs_value' => field_1.id, 'lhs_which' => 1,
              'rhs_type' => 'field', 'rhs_value' => field_2.id, 'rhs_which' => 2,
              'operator' => 'equals'
            }]
          })
          runner = Runner.new(scenario)
          runner.run!

          groups = {}
          scenario.local_database do |db|
            assert db.tables.include?(:groups_records_1)
            ds = db[:groups_records_1]
            assert_equal 22000, ds.count

            counts = ds.group_and_count(:group_id).all
            assert_equal 530, counts.length
            counts = counts.inject({}) { |h, r| h[r[:count]] ||= 0; h[r[:count]] += 1; h }
            assert_equal 30, counts[700]
            assert_equal 500, counts[2]
            assert ds.group_and_count(:record_id, :resource_id).all? { |r| r[:count] == 1 }

            ds = db[:groups_1]
            assert_equal 530, ds.count
          end
        end
      end
    end
  end
end
