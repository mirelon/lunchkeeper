require 'test_helper'

class ObedovatControllerTest < ActionController::TestCase
  test "should get show_menu" do
    get :show_menu
    assert_response :success
  end

  test "should get eat" do
    get :eat
    assert_response :success
  end

end
