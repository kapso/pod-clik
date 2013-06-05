require "spec_helper"

describe "User Routes" do
  describe "#create" do
    it "routes to #create" do
      { post: "v1/users", format: :json }.should route_to(controller: "v1/users", action: "create")
    end
  end

  describe "#update" do
    it "routes to #update" do
      { put: "v1/users/123", format: :json }.should route_to(controller: "v1/users", action: "update", id: "123")
    end
  end

  describe "#show" do
    it "routes to #show" do
      { get: "v1/users/123", format: :json }.should route_to(controller: "v1/users", action: "show", id: "123")
    end
  end

  describe "#me" do
    it "routes to #me" do
      { get: "v1/users/self", format: :json }.should route_to(controller: "v1/users", action: "me")
    end
  end
end
