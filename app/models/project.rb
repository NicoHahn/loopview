class Project < ApplicationRecord

  has_many :concrete_issue_templates
  validates :external_key, presence: true

  # def create_missing_projects(projects)
  #   projects.each do |p|
  #     project = Project.find_by(external_id: p[:id].to_i, external_key: p[:key])
  #     if project.nil?
  #       # project needs a title
  #       Project.create(external_id: p[:id].to_i, external_key: p[:key])
  #     end
  #   end
  # end

end
