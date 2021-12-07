require 'test_helper'

class IssueTemplateTest < ActiveSupport::TestCase

  setup do
    @issue_template = issue_templates(:issue_template_1)
    @concrete_issue_template = concrete_issue_templates(:concrete_issue_template_1)
  end

  test "#created_for_project?" do
    assert_not @issue_template.created_for_project?(projects(:project_1))
    @concrete_issue_template.connect_with_issue(3000)
    assert @issue_template.created_for_project?(projects(:project_1))
  end

  test "#concrete_template_existing?" do
    assert @issue_template.concrete_template_existing?(projects(:project_1))
    assert_not @issue_template.concrete_template_existing?(projects(:project_2))
  end

end
