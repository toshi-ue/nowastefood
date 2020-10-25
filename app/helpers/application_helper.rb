module ApplicationHelper
  def change_font_weight(current_page, should_adaptive_action_name)
    if current_page == should_adaptive_action_name
      'font-weight-bold'
    else
      ''
    end
  end
end
