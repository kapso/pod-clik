require "spec_helper"

describe "Auth Routes" do
  describe "#signin" do
    it "routes to #signin" do
      { post: "/auth/signin", format: :json }.should route_to(controller: "auth", action: "signin")
    end
  end

  describe "#signout" do
    it "routes to #signout" do
      { post: "/auth/signout", format: :json }.should route_to(controller: "auth", action: "signout")
    end
  end
end
