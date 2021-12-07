require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "presence validation of external key on create" do
    @project = Project.new
    assert_not @project.valid?
    @project.external_key = "TEST"
    assert @project.valid?
  end

end
