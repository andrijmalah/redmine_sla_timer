# dispatcher = Rails.version < '5.1' ? ActionDispatch::Callbacks : ActiveSupport::Reloader
# dispatcher.to_prepare do
#   require 'shared'
#   require 'issues_controller_patch'
#   require 'issue_patch'
#   require 'issues_controller_hook'
# end