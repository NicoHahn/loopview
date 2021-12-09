require 'test_helper'

class IssueTemplatesControllerTest < ActionDispatch::IntegrationTest

  setup do
    post sessions_url, params: {email: users(:user_1).email, password: "asdf"}
  end

  test "create blank issue_template with a title" do
    post issue_templates_path, params: {issue_template: {title: "test_template"}}
    @issue_template = IssueTemplate.last
    assert_equal "test_template", @issue_template.title
    assert_empty IssueTemplateAttribute.where(issue_template_id: @issue_template.id)
    assert_redirected_to edit_issue_template_path(id: @issue_template.id)
  end

  test "add attribute to not already existing issue_template" do
    post add_attribute_issue_templates_path, params: {title: "test_template", attribute_type: 0}
    @issue_template = IssueTemplate.last
    assert_equal "test_template", @issue_template.title
    response = JSON.parse(@response.body)
    assert_equal "/issue_templates/#{response["id"]}/edit", response["location"]
    assert_equal @issue_template, IssueTemplateAttribute.last.issue_template
  end

  test "update title of issue_template and update attribute" do
    post issue_templates_path, params: {issue_template: {title: "test_template"}}
    @issue_template = IssueTemplate.last
    assert_equal "test_template", @issue_template.title
    patch issue_template_path(id: @issue_template.id), params: {issue_template: {title: "test_template_test", issue_template_attributes: ""}}
    @issue_template.reload
    assert_equal "test_template_test", @issue_template.title
    post add_attribute_issue_templates_path, params: {id: @issue_template.id, attribute_type: 0}
    @issue_template_attribute = IssueTemplateAttribute.last
    assert_equal @issue_template, @issue_template_attribute.issue_template
    patch issue_template_path(id: @issue_template.id), params: {
      issue_template: {
        title: "test_template_test", issue_template_attributes_attributes: [field_value: "test_value", id: @issue_template_attribute.id]
      }
    }
    @issue_template_attribute.reload
    assert_equal "test_value", @issue_template_attribute.field_value
  end

end
