# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tops" do
  describe "GET /about" do
    it "aboutページが表示されること" do
      get about_path
      expect(response).to have_http_status :ok
      expect(response.body).to include "make Cooking Menu Easier"
    end
  end
end
