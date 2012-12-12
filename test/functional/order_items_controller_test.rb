require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

end
