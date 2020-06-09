require_dependency 'issue_query'

module IssueQueryPath
  extend ActiveSupport::Concern

  included do
    self.available_columns << QueryColumn.new(:sla_timer)
  end 
end
IssueQuery.send :include, IssueQueryPath