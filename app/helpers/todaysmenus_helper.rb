module TodaysmenusHelper
  def serving_count_num(tm)
    ary = []
    if tm.serving_count >= 3
      5.times { |n| ary << (tm.serving_count- 2) + n}
    else
      5.times { |n| ary << n + 1}
    end
    ary
  end
end
