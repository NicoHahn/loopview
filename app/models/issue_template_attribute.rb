class IssueTemplateAttribute < ApplicationRecord

  ATTRIBUTE_TYPES = [
    TYPE_GENERAL_DESCRIPTION = 0,
    TYPE_TECHNICAL_DESCRIPTION = 1,
    TYPE_UNORDERED_LIST = 2,
    TYPE_ORDERED_LIST = 3,
    TYPE_CODEBLOCK = 4
  ]

end
