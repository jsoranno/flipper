require 'helper'

RSpec.describe Flipper::UI::Actions::Feature do
  describe "DELETE /features/:feature" do
    before do
      flipper.enable :search
      delete "/features/search",
        {"authenticity_token" => "a"},
        "rack.session" => {"_csrf_token" => "a"}
    end

    it "removes feature" do
      expect(flipper.features.map(&:key)).not_to include("search")
    end

    it "redirects to features" do
      expect(last_response.status).to be(302)
      expect(last_response.headers["Location"]).to eq("/features")
    end
  end

  describe "POST /features/:feature with _method=DELETE" do
    before do
      flipper.enable :search
      post "/features/search",
        {"_method" => "DELETE", "authenticity_token" => "a"},
        "rack.session" => {"_csrf_token" => "a"}
    end

    it "removes feature" do
      expect(flipper.features.map(&:key)).not_to include("search")
    end

    it "redirects to features" do
      expect(last_response.status).to be(302)
      expect(last_response.headers["Location"]).to eq("/features")
    end
  end

  describe "GET /features/:feature" do
    before do
      get "/features/search"
    end

    it "responds with success" do
      expect(last_response.status).to be(200)
    end

    it "renders template" do
      expect(last_response.body).to include("search")
      expect(last_response.body).to include("Enable")
      expect(last_response.body).to include("Disable")
      expect(last_response.body).to include("Actors")
      expect(last_response.body).to include("Groups")
      expect(last_response.body).to include("Percentage of Time")
      expect(last_response.body).to include("Percentage of Actors")
    end
  end
end
