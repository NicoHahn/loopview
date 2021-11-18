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
      url = URI("https://loopview.atlassian.net/rest/api/3/issue/#{issue_id}")
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

  private

  def build_data(params)
    # build data structure as json for request body
  end

  def get_authorization_header_value(user)
    "Basic #{Base64.encode64("#{user.email}:#{user.api_key}")}"
  end

end
