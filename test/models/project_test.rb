require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "a project needs to have an external key" do

    @project = Project.new
    assert_not @project.valid?
    @project.external_key = "TEST"
    assert @project.valid?
  end

end
