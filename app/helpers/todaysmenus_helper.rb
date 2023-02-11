# frozen_string_literal: true

module TodaysmenusHelper
  def serving_count_num(todaysmenu)
    ary = []
    if todaysmenu.serving_count >= 3
      5.times { |n| ary << ((todaysmenu.serving_count - 2) + n) }
    else
      5.times { |n| ary << (n + 1) }
    end
    ary
  end
end
