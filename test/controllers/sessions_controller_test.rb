require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:user_1)
  end

  test "should create a new session" do
    post sessions_url, params: {email: @user.email, password: "asdf"}
    assert_redirected_to root_path
    assert_equal "Erfolgreich angemeldet!", flash[:success]
  end

  test "should not create a new session" do
    post sessions_url, params: {email: @user.email, password: "qwer"}
    assert_redirected_to '/login'
    assert_equal "Ungültige E-Mail / Passwort Kombination", flash[:danger]
  end

  test "should destroy session" do
    post sessions_url, params: {email: @user.email, password: "asdf"}
    assert_redirected_to root_path
    assert_equal "Erfolgreich angemeldet!", flash[:success]
    get logout_path
    assert_redirected_to '/login'
    assert_equal "Erfolgreich abgemeldet!", flash[:success]
  end

end
