# frozen_string_literal: true
require "simplecov"
SimpleCov.start
Rails.application.eager_load!

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def parameters_from_instance(instance)
    table_name = instance.class.table_name.singularize
    column_names = instance.class.column_names - %w[id created_at updated_at]
    param_values = {}
    column_names.each do |cn|
      param_values[cn] = instance[cn] unless instance[cn].nil?
    end
    { table_name => param_values }
  end

  def assert_save(local_record, saved_record, fields = [], message = "")
    assert_equal diff_active_record(local_record, saved_record), fields, message
  end

  def assert_no_save(local_record, saved_record, fields, message = "")
    assert_equal diff_active_record(local_record, saved_record), fields, message
  end

  def assert_organisation(saved_record, organisation)
    assert_equal saved_record.organisation, organisation
  end

  def assert_project(saved_record, project)
    assert_equal saved_record.project, project
  end

  def assert_in_organisation(records, organisation)
    records.each do |record|
      assert_equal record.organisation, organisation
    end
  end

  def assert_in_project(records, project)
    records.each do |record|
      assert_equal record.project, project
    end
  end

  def diff_active_record(record_a, record_b)
    diffs = (record_a.attributes.to_a - record_b.attributes.to_a).map(&:first)
    diffs - %w[id created_at updated_at]
  end
end
