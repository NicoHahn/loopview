require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "#get_fullname" do
    assert_equal "Firstname Lastname", users(:user_1).full_name
  end

  test "validation of email format" do
    @user = User.new(firstname: "test_first", lastname: "test_last", email: "123.123", password_digest: "12345")
    assert_not @user.valid?
    @user.email = "test@mail.com"
    assert @user.valid?
  end

end
