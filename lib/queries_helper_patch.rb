require_dependency 'queries_helper'

module QueriesHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      # unloadable
      alias_method :column_value_without_sla_timer, :column_value
      alias_method :column_value, :column_value_with_sla_timer
    end
  end

  module InstanceMethods
    def column_value_with_sla_timer(column, item, value)
      html_value = column_value_without_sla_timer(column, item, value)
      if column.name == :sla_timer
        html_value = content_tag(:span, html_value, style: "color:#{item.sla_timer_font_color};")
      end
      html_value
    end
  end
end

unless QueriesHelper.included_modules.include?(QueriesHelperPatch)
  QueriesHelper.send :include, QueriesHelperPatch
end
