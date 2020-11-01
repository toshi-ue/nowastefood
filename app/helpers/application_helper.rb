module ApplicationHelper
  def add_class_to_text(current_page, should_adaptive_action_name)
    if current_page == should_adaptive_action_name
      'font-weight-bold text-black'
    else
      'text-black-50'
    end
  end
end
