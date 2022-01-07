# frozen_string_literal: true

require "test_helper"

class TaskBooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @test_book = test_books(:one)
  end

  test "should get index" do
    sign_in @bob
    get test_books_path
    assert_in_organisation(assigns(:test_books), @bob.current_organisation)
    assert_in_project(assigns(:test_books), @bob.current_project)
    assert_response :success
  end

  test "should not get index" do
    get test_books_path
    assert_redirected_to new_user_session_path
  end
end
