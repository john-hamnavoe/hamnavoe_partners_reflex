# frozen_string_literal: true

require "test_helper"

class TestStepNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @test_case = test_cases(:one)
    @test_step = TestStep.new(title: "TestStepNewTest", description: "fuller description than name", test_case: @test_case)
  end

  test "should create test_step within organisation" do
    sign_in @bob
    assert_difference "TestStep.count", + 1 do
      post_test_step
    end
    assert_redirected_to test_book_path(@test_case.test_book)
    @saved_test_step = TestStep.find_by(title: "TestStepNewTest")
    assert_save @test_step, @saved_test_step, %w[organisation_id project_id position], "Expect to save organisation and project set based on user"
    assert_organisation(@saved_test_step, @bob.current_organisation)
    assert_project(@saved_test_step, @bob.current_project)
  end

  test "should not create test_step within organisation" do
    sign_in @bob
    @test_step.title = "a" * 101
    assert_no_difference "TestStep.count" do
      post_test_step
    end
    assert_response :success
    test_step = assigns(:test_step)
    assert_not test_step.valid?
    @saved_test_step = TestStep.find_by(title: "a" * 101)
    assert_nil @saved_test_step
  end

  private

  def updated_fields
    %w[title description]
  end

  def post_test_step
    post test_steps_path, params: parameters_from_instance(@test_step)
  end
end
