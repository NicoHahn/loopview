require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  NEW_USER_MAIL = "new@user.com"

  setup do
    @user = users(:user_1)
  end

  test "should create user with given email" do
    post sessions_url, params: {password: "asdf", email: @user.email}
    assert_nil User.find_by(email: NEW_USER_MAIL)
    post users_url, params: {email: NEW_USER_MAIL}
    assert_not_nil User.find_by(email: NEW_USER_MAIL)
    assert_redirected_to root_path
  end

  test "try to verify with wrong email api combination on first login" do
    assert_nil User.find_by(email: NEW_USER_MAIL)
    post users_url, params: {email: NEW_USER_MAIL, password: "new_password", api_key: "1a2b3c"}
    assert_nil User.find_by(email: NEW_USER_MAIL)
    assert_redirected_to root_path
    assert_equal "Die eingegebene Kombination aus E-Mail und API-Schlüssel scheint nicht korrekt zu sein.",
                 flash[:warning]
  end

end
