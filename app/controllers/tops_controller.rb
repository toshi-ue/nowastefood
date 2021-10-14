class TopsController < ApplicationController
  def index
    @japanese_style_cuisines = Cuisine.japanese.five_contents
    @western_style_cuisines = Cuisine.western.five_contents
    @chinese_style_cuisines = Cuisine.chinese.five_contents
    @other_style_cuisines = Cuisine.other.five_contents

    # @tags = ActsAsTaggableOn::Tag.all
  end

  def about; end

  def login_which; end
end
