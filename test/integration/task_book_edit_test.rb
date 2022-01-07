# frozen_string_literal: true

require "test_helper"

class TestBookEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @test_book = test_books(:one)
    update_test_book
  end

  test "should update test_book within organisation" do
    sign_in @bob
    assert_no_difference "TestBook.count" do
      put_test_book
    end
    assert_redirected_to test_books_path
    @saved_test_book = TestBook.find_by(id: @test_book.id)
    assert_save @test_book, @saved_test_book
  end

  test "should not update test_book within organisation" do
    sign_in @bob
    @test_book.name = "a" * 51
    assert_no_difference "TestBook.count" do
      put_test_book
    end
    assert_response :success
    test_book = assigns(:test_book)
    assert_not test_book.valid?
    @saved_test_book = TestBook.find_by(id: @test_book.id)
    assert_no_save @test_book, @saved_test_book, updated_fields
  end

  test "should not update test_book within organisation when not logged in" do
    assert_no_difference "TestBook.count" do
      put_test_book
    end
    assert_redirected_to new_user_session_path
    @saved_test_book = TestBook.find_by(id: @test_book.id)
    assert_no_save @test_book, @saved_test_book, updated_fields
  end

  test "should not update test_book in other organisation" do
    @test_book = test_books(:two)
    update_test_book
    sign_in @bob
    assert_no_difference "TestBook.count" do
      put_test_book
    end
    assert_response :unprocessable_entity
    @saved_test_book = TestBook.find_by(id: @test_book.id)
    assert_no_save @test_book, @saved_test_book, updated_fields
  end

  private

  def updated_fields
    %w[name is_shared]
  end

  def update_test_book
    @test_book.is_shared = !@test_book.is_shared
    @test_book.name = "updated name"
  end

  def put_test_book
    put test_book_path(@test_book), params: parameters_from_instance(@test_book)
  end
end
