require 'test_helper'

class KeepersControllerTest < ActionController::TestCase
  setup do
    @keeper = keepers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keepers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keeper" do
    assert_difference('Keeper.count') do
      post :create, keeper: { name: @keeper.name }
    end

    assert_redirected_to keeper_path(assigns(:keeper))
  end

  test "should show keeper" do
    get :show, id: @keeper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keeper
    assert_response :success
  end

  test "should update keeper" do
    put :update, id: @keeper, keeper: { name: @keeper.name }
    assert_redirected_to keeper_path(assigns(:keeper))
  end

  test "should destroy keeper" do
    assert_difference('Keeper.count', -1) do
      delete :destroy, id: @keeper
    end

    assert_redirected_to keepers_path
  end
end
