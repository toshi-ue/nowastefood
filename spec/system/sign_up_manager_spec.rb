require 'rails_helper'

RSpec.describe "sample test", type: :system, js: true do
  it 'xxx' do
    save_and_open_page
    visit root_path
  end
end
