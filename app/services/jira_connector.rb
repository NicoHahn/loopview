require 'net/http'
require 'openssl'

class JiraConnector
  # generate api token:
  # https://id.atlassian.com/manage/api-tokens

  def self.import_current_projects
    projects_response = send_request(:get, "https://loopview.atlassian.net/rest/api/3/project", current_user)
    Project.create_missing_projects(projects_response)
  end

  def self.send_request(type, url, user, issue_id=nil, concrete_issue_id=nil)
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
      data = build_data(concrete_issue_id)
      url = URI(url)
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

  def self.build_data(concrete_issue_id)
    concrete_issue_template = ConcreteIssueTemplate.find_by(id: concrete_issue_id)
    issue_template = concrete_issue_template.issue_template
    project = Project.find_by!(id: concrete_issue_template.project_id)
    template_values = concrete_issue_template.concrete_template_values
    body_data = {
      "fields": {
        "project": {
          "key": "#{project.external_key}"
        },
        "issuetype": {
          "name": "Task"
        },
        "summary": "#{issue_template.title}",
        "description": {
          "type": "doc",
          "version": 1,
          "content": [
          ]
        }
      },
    }

    template_values.each do |tv|
      attribute = IssueTemplateAttribute.find_by!(id: tv.issue_template_attribute_id)
      case attribute.attribute_type
      when IssueTemplateAttribute::TYPE_GENERAL_DESCRIPTION
        body_data = set_heading(body_data, attribute)
        body_data[:fields][:description][:content] << {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "#{tv.extended_field_value}"
            }
          ]
        }
        body_data = add_line_break(body_data)
      when IssueTemplateAttribute::TYPE_TECHNICAL_DESCRIPTION
        body_data = set_heading(body_data, attribute)
        body_data[:fields][:description][:content] << {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "#{tv.extended_field_value}"
            }
          ]
        }
        body_data = add_line_break(body_data)
      when IssueTemplateAttribute::TYPE_KEY_VALUE
        body_data = set_heading(body_data, attribute)
        body_data[:fields][:description][:content] << {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "#{tv.extended_field_value}"
            }
          ]
        }
        body_data = add_line_break(body_data)
      when IssueTemplateAttribute::TYPE_CODEBLOCK
        body_data = set_heading(body_data, attribute)
        body_data[:fields][:description][:content] << {
          "type": "codeBlock",
          "attrs": {
            "language": "html" # the attribute or the value needs to have an attribute for the language
          },
          "content": [
            {
                "type": "text",
                "text": "#{tv.extended_field_value}"
            }
          ]
        }
        body_data = add_line_break(body_data)
      end
    end
    body_data
  end

  def self.get_authorization_header_value(user)
    "Basic #{Base64.strict_encode64("#{user.email}:#{user.api_key}")}" #.gsub("\n", "\\\\n")
  end

  def self.set_heading(body_data, attribute)
    body_data[:fields][:description][:content] << {
      "type": "heading",
        "attrs": {
            "level": 1
        },
        "content": [
            {
                "type": "text",
                "text": I18n.t('template_type_'+attribute.attribute_type.to_s)
            }
        ]
    }
    body_data[:fields][:description][:content] << {
      "type": "heading",
      "attrs": {
        "level": 3
      },
      "content": [
        {
          "type": "text",
          "text": "#{attribute.field_value}"
        }
      ]
    }
    body_data
  end

  def self.add_line_break(body_data)
    body_data[:fields][:description][:content] << {
      "type": "paragraph",
      "content": []
    }
    body_data
  end

end
