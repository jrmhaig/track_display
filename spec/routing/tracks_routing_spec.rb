require "rails_helper"

RSpec.describe TracksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/tracks")).to route_to("tracks#index")
    end

    it "routes to #show" do
      expect(get("/tracks/1")).to route_to("tracks#show", id: '1')
    end

    it "routes to #destroy" do
      expect(delete("/tracks/1")).to route_to("tracks#destroy", id: '1')
    end

    it "routes to #edit" do
      expect(get("/tracks/1/edit/")).to route_to("tracks#edit", id: '1')
    end

    it "routes to #update" do
      expect(patch("/tracks/1")).to route_to("tracks#update", id: '1')
    end

    it "routes to #import" do
      expect(post("/tracks/import")).to route_to("tracks#import")
    end

  end
end
