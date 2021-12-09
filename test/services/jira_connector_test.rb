require 'test_helper'

class JiraConnectorTest < ActiveSupport::TestCase

  setup do
    @user = users(:user_1)
    @user.api_key = "12345asdfg"
    @body_data = {
      "fields": {
        "project": {
          "key": projects(:project_1).external_key
        },
        "issuetype": {
          "name": "Task"
        },
        "summary": issue_templates(:issue_template_1).title,
        "description": {
          "type": "doc",
          "version": 1,
          "content": []
        }
      },
    }
  end

  test "#get_authorization_header" do
    assert_not_equal @user.api_key, JiraConnector.send(:get_authorization_header_value, @user)
    assert_not_equal "Basic " + @user.api_key, JiraConnector.send(:get_authorization_header_value, @user)
    assert_not_equal Base64.strict_encode64(@user.api_key), JiraConnector.send(:get_authorization_header_value, @user)
    expected_encoded = "Basic " + Base64.strict_encode64("#{@user.email}:#{@user.api_key}")
    assert_equal expected_encoded, JiraConnector.send(:get_authorization_header_value, @user)
    assert_not_equal JiraConnector.send(:get_authorization_header_value, @user),
                     JiraConnector.send(:get_authorization_header_value, users(:user_2))
    assert_equal "#{@user.email}:#{@user.api_key}", Base64.strict_decode64(expected_encoded.split(" ").last)
  end

  test "#add_heading" do
    assert @body_data[:fields][:description][:content].empty?
    JiraConnector.add_heading(@body_data, issue_template_attributes(:issue_template_attribute_1), [1])
    assert_not @body_data[:fields][:description][:content].empty?
    assert_equal 1, @body_data[:fields][:description][:content].size
    JiraConnector.add_heading(@body_data, issue_template_attributes(:issue_template_attribute_1), [3])
    assert_not @body_data[:fields][:description][:content].empty?
    assert_equal 2, @body_data[:fields][:description][:content].size
    assert_equal "heading", @body_data[:fields][:description][:content].last[:type]
    assert_equal "heading", @body_data[:fields][:description][:content].first[:type]
    assert_equal 3, @body_data[:fields][:description][:content].last[:attrs][:level]
    assert_equal 1, @body_data[:fields][:description][:content].first[:attrs][:level]
  end

  test "#add_line_break" do
    assert @body_data[:fields][:description][:content].empty?
    JiraConnector.add_line_break(@body_data)
    assert_not @body_data[:fields][:description][:content].empty?
    assert_equal "paragraph", @body_data[:fields][:description][:content].first[:type]
    assert @body_data[:fields][:description][:content].first[:content].empty?
  end

end
