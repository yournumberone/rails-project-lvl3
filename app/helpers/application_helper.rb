# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    case type
    when 'error', 'alert'
      'alert-danger'
    when 'notice'
      'alert-primary'
    when 'success'
      'alert-success'
    else
      type.to_s
    end
  end

  def datetime_abb_month(datetime)
    datetime.strftime('%H:%M %B %d %Y')
  end
end
