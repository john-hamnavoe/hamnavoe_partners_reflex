# frozen_string_literal: true

require "test_helper"

class TestCaseNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @test_book = test_books(:one)
    @test_case = TestCase.new(name: "TestCaseNewTest", test_book: @test_book)
  end

  test "should create test_case within organisation" do
    sign_in @bob
    assert_difference "TestCase.count", + 1 do
      post_test_case
    end
    assert_redirected_to test_book_path(@test_book)
    @saved_test_case = TestCase.find_by(name: "TestCaseNewTest")
    assert_save @test_case, @saved_test_case, %w[organisation_id project_id position], "Expect to save organisation and project set based on user"
    assert_organisation(@saved_test_case, @bob.current_organisation)
    assert_project(@saved_test_case, @bob.current_project)
  end

  test "should not create test_case within organisation" do
    sign_in @bob
    @test_case.name = "a" * 51
    assert_no_difference "TestCase.count" do
      post_test_case
    end
    assert_response :success
    test_case = assigns(:test_case)
    assert_not test_case.valid?
    @saved_test_case = TestCase.find_by(name: "a" * 51)
    assert_nil @saved_test_case
  end

  private

  def updated_fields
    %w[name is_active]
  end

  def post_test_case
    post test_cases_path, params: parameters_from_instance(@test_case)
  end
end
