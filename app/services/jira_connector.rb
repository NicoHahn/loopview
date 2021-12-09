require 'net/http'
require 'openssl'

class JiraConnector

  # Es wird immer nur ein Prozess zur Zeit gestartet vom rails server
  # Wenn Prozesse parallelisiert werden würden, dann müsste das über einzelne Instanzen laufen
  # generischen jira connector der nur zusammen gebaute daten bekommt
  #   Date Objekt sollte fertig übergeben werden

  # generate api token:
  # https://id.atlassian.com/manage/api-tokens

  def self.send_request(type, url, user, issue_id=nil, concrete_issue=nil)
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
      data = build_data(concrete_issue)
      url = URI(url)
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Authorization"] = get_authorization_header_value(user)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      https.request(request)
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

  def self.build_data(concrete_issue_template)
    issue_template = concrete_issue_template.issue_template
    project = concrete_issue_template.project
    template_values = concrete_issue_template.concrete_template_values
    body_data = {
      "fields": {
        "project": {
          "key": project.external_key
        },
        "issuetype": {
          "name": "Task"
        },
        "summary": issue_template.title,
        "description": {
          "type": "doc",
          "version": 1,
          "content": []
        }
      },
    }

    template_values.each do |tv|
      attribute = tv.issue_template_attribute
      case attribute.attribute_type
      when IssueTemplateAttribute::TYPE_GENERAL_DESCRIPTION,
           IssueTemplateAttribute::TYPE_TECHNICAL_DESCRIPTION,
           IssueTemplateAttribute::TYPE_KEY_VALUE
        body_data = add_heading(body_data, attribute, [1, 3])
        unless tv.extended_field_value.blank?
          body_data[:fields][:description][:content] << {
            "type": "paragraph",
            "content": [
              {
                "type": "text",
                "text": tv.extended_field_value
              }
            ]
          }
        end
        body_data = add_line_break(body_data)
      when IssueTemplateAttribute::TYPE_CODEBLOCK
        body_data = add_heading(body_data, attribute, [1, 3])
        body_data[:fields][:description][:content] << {
          "type": "codeBlock",
          "attrs": {
            "language": tv.issue_template_attribute.optional_code_language
          },
          "content": [
            {
                "type": "text",
                "text": tv.extended_field_value
            }
          ]
        }
        body_data = add_line_break(body_data)
      when IssueTemplateAttribute::TYPE_ORDERED_LIST
        content = []
        attribute.optional_size.times do |idx|
          next if tv.dynamic_size_data[idx.to_s].empty?
          content << { "type": "listItem", "content": [{ "type": "paragraph", "content": [
            { "type": "text", "text": tv.dynamic_size_data[idx.to_s] }] }
          ] }
        end
        body_data = add_heading(body_data, attribute, [3])
        body_data[:fields][:description][:content] << {
          "type": "orderedList",
          "content": content
        }
      when IssueTemplateAttribute::TYPE_UNORDERED_LIST
        content = []
        attribute.optional_size.times do |idx|
          next if tv.dynamic_size_data[idx.to_s].empty?
          content << { "type": "listItem", "content": [{ "type": "paragraph", "content": [
            { "type": "text", "text": tv.dynamic_size_data[idx.to_s] }] }
          ] }
        end
        body_data = add_heading(body_data, attribute, [3])
        body_data[:fields][:description][:content] << {
          "type": "bulletList",
          "content": content
        }
      end
    end
    body_data
  end

  private

  def self.get_authorization_header_value(user)
    "Basic #{Base64.strict_encode64("#{user.email}:#{user.api_key}")}"
  end

  def self.add_heading(body_data, attribute, levels)
    levels.each do |l|
      body_data[:fields][:description][:content] << {
        "type": "heading",
          "attrs": {
              "level": l
          },
          "content": [
              {
                  "type": "text",
                  "text": l==1 ? I18n.t('template_type_'+attribute.attribute_type.to_s) : attribute.field_value
              }
          ]
      }
    end
    body_data
  end

  def self.add_line_break(body_data)
    body_data[:fields][:description][:content] << {
      "type": "paragraph",
      "content": []
    }
    body_data
  end

  def self.verify_user(email, api_key)
    url = URI("https://loopview.atlassian.net/rest/api/3/user/search?query=#{email}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Basic #{Base64.strict_encode64("#{email}:#{api_key}")}"
    response = https.request(request)
    response.code=="200"
  end

end
