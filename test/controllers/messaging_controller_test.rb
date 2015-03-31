require 'test_helper'

class MessagingControllerTest < ActionController::TestCase
  test "should get send" do
    get :send
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
