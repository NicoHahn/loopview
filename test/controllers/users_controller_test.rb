require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  NEW_USER_MAIL = "new@user.com"

  setup do
    @user = users(:user_1)
    post sessions_url, params: {password: "asdf", email: @user.email}
  end

  test "should create user with given email" do
    assert_nil User.find_by(email: NEW_USER_MAIL)
    post users_url, params: {email: NEW_USER_MAIL}
    assert_not_nil User.find_by(email: NEW_USER_MAIL)
    assert_redirected_to root_path
  end

end
