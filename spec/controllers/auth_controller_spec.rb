require "spec_helper"

describe AuthController do
  let(:user) { FactoryGirl.create(:user, password: "secret", phone_number: "(111)111-1111") }
  let(:json) { MultiJson.load(response.body) }

  describe "#signin" do
    context "valid email and password" do
      it "authenticates user" do
        User.any_instance.should_receive(:sms_phone_verify_code)
        post :signin, format: :json, email: user.email, password: "secret"
        response.should be_success
        json.keys.should_not be_nil
        json.keys.should include("user")
        json["user"].keys.should include("auth_token", "id", "email", "phone_number")
      end
    end

    context "valid phone number and password" do
      it "authenticates user" do
        User.any_instance.should_receive(:sms_phone_verify_code)
        post :signin, format: :json, phone_number: user.phone_number, password: "secret"
        response.should be_success
        json.keys.should_not be_nil
        json.keys.should include("user")
        json["user"].keys.should include("auth_token", "id", "email", "phone_number")
      end
    end

    it "returns error code 404 if user cannot be authenticated" do
      User.any_instance.should_receive(:sms_phone_verify_code)
      post :signin, format: :json, email: user.email, password: "notmysecret"
      response.should_not be_success
      json.keys.should include("errors")
      response.code.should == "404"
    end
  end

  describe "#signout" do
    let(:user) { FactoryGirl.create(:user) }

    it "should signout a user" do
      User.any_instance.should_receive(:sms_phone_verify_code)
      request.headers[Settings.auth_token_key] = user.remember_me_token
      post :signout
      response.code.should == "204"
    end

    context "when auth token missing" do
      it "should fail" do
        post :signout
        response.should_not be_success
      end
    end
  end
end
