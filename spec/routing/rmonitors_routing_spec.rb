require "spec_helper"

describe RmonitorsController do
  describe "routing" do

    it "routes to #index" do
      get("/rmonitors").should route_to("rmonitors#index")
    end

    it "routes to #new" do
      get("/rmonitors/new").should route_to("rmonitors#new")
    end

    it "routes to #show" do
      get("/rmonitors/1").should route_to("rmonitors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rmonitors/1/edit").should route_to("rmonitors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rmonitors").should route_to("rmonitors#create")
    end

    it "routes to #update" do
      put("/rmonitors/1").should route_to("rmonitors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rmonitors/1").should route_to("rmonitors#destroy", :id => "1")
    end

  end
end
