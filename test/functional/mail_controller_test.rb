require 'test_helper'

class MailControllerTest < ActionController::TestCase
  test "should get receiver" do
    get :receiver
    assert_response :success
  end

end
