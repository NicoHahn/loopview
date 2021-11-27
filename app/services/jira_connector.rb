require 'net/http'
require 'openssl'

class JiraConnector
  # generate api token:
  # https://id.atlassian.com/manage/api-tokens

  def self.import_current_projects
    projects_response = send_request(:get, "https://loopview.atlassian.net/rest/api/3/project", current_user)
    Project.create_missing_projects(projects_response)
  end

  def self.send_request(type, url, user, issue_id=nil, params=nil)
    case type
    when :get
      url = URI(url)
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Authorization"] = get_authorization_header_value(user)
      response = https.request(request)
      JSON.parse(response.body)
    when :post
      data = build_data(params)
      url = URI("https://loopview.atlassian.net/rest/api/3/issue")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Authorization"] = get_authorization_header_value(user)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      response = https.request(request)
      JSON.parse(response.body)
    end
  end

  def self.check_for_project(project_key, user)
    response = send_request(:get, "https://loopview.atlassian.net/rest/api/3/project/#{project_key}", user)
    if response["errorMessages"] && response["errorMessages"].any?
      [nil, nil, false]
    else
      [response["id"], response["name"], true]
    end
  end

  private

  def build_data(params)
    concrete_issue_template = ConcreteIssueTemplate.find_by(params[:concrete_issue_template_id])
    project = concrete_issue_template.project.external_key
    template_attributes = concrete_issue_template.issue_template.issue_template_attributes
    template_values = concrete_issue_template.concrete_template_values
  end

  def self.get_authorization_header_value(user)
    "Basic #{Base64.encode64("#{user.email}:#{user.api_key}")}".gsub("\n", "\\\\n")
  end

end
