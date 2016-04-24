require 'test_helper'

class StockUsersControllerTest < ActionController::TestCase
  setup do
    @stock_user = stock_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_user" do
    assert_difference('StockUser.count') do
      post :create, stock_user: { stock_id: @stock_user.stock_id, user_id: @stock_user.user_id }
    end

    assert_redirected_to stock_user_path(assigns(:stock_user))
  end

  test "should show stock_user" do
    get :show, id: @stock_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stock_user
    assert_response :success
  end

  test "should update stock_user" do
    patch :update, id: @stock_user, stock_user: { stock_id: @stock_user.stock_id, user_id: @stock_user.user_id }
    assert_redirected_to stock_user_path(assigns(:stock_user))
  end

  test "should destroy stock_user" do
    assert_difference('StockUser.count', -1) do
      delete :destroy, id: @stock_user
    end

    assert_redirected_to stock_users_path
  end
end
