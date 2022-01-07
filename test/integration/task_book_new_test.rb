# frozen_string_literal: true

require "test_helper"

class TestBookNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @test_book = TestBook.new(name: "TestBookNewTest", is_shared: true)
  end

  test "should create test_book within organisation" do
    sign_in @bob
    assert_difference "TestBook.count", + 1 do
      post_test_book
    end
    assert_redirected_to test_books_path
    @saved_test_book = TestBook.find_by(name: "TestBookNewTest")
    assert_save @test_book, @saved_test_book, %w[organisation_id project_id], "Expect to save and owner, organisation and project set based on user"
    assert_organisation(@saved_test_book, @bob.current_organisation)
    assert_project(@saved_test_book, @bob.current_project)
  end

  test "should not create test_book within organisation" do
    sign_in @bob
    @test_book.name = "a" * 51
    assert_no_difference "TestBook.count" do
      post_test_book
    end
    assert_response :success
    test_book = assigns(:test_book)
    assert_not test_book.valid?
    @saved_test_book = TestBook.find_by(name: "a" * 51)
    assert_nil @saved_test_book
  end

  private

  def updated_fields
    %w[name is_shared]
  end

  def post_test_book
    post test_books_path, params: parameters_from_instance(@test_book)
  end
end
