# frozen_string_literal: true

module ApplicationHelper
  def add_class_to_text(current_page, should_adaptive_action_name)
    if current_page == should_adaptive_action_name
      'font-weight-bold text-black'
    else
      'text-black-50'
    end
  end

  def add_class_nav_link(current_page, should_adaptive_action_name)
    if current_page == should_adaptive_action_name
      'nav-link active'
    else
      'nav-link'
    end
  end
end
