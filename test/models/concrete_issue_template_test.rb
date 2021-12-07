require 'test_helper'

class ConcreteIssueTemplateTest < ActiveSupport::TestCase

  setup do
    @concrete_issue_template = concrete_issue_templates(:concrete_issue_template_1)
  end

  test "#connect_with_issue" do
    assert_nil @concrete_issue_template.external_id
    @concrete_issue_template.connect_with_issue(3000)
    assert_not_nil @concrete_issue_template.external_id
    assert_equal 3000, @concrete_issue_template.external_id
  end

end
