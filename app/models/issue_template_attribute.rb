class IssueTemplateAttribute < ApplicationRecord

  belongs_to :issue_template

  TYPE_GENERAL_DESCRIPTION = 0
  TYPE_TECHNICAL_DESCRIPTION = 1
  TYPE_UNORDERED_LIST = 2
  TYPE_ORDERED_LIST = 3
  TYPE_CODEBLOCK = 4
  TYPE_KEY_VALUE = 5

  ATTRIBUTE_TYPES = [ 0, 1, 2, 3, 4, 5 ]

  TEXT_FIELD_ATTRIBUTES = [ 0, 1, 4, 5 ]

  LIST_FIELD_ATTRIBUTES = [ 2, 3 ]

end
