require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET /about" do
    it "aboutページが表示されること" do
      get tops_about_path
      expect(response.status).to eq 200
      expect(response.body).to include "make Cooking Menu Easier"
    end
  end
end
