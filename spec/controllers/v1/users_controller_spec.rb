require "spec_helper"

describe V1::UsersController do
  describe "#create" do
    let(:school) { FactoryGirl.create(:school) }
    let(:user_hash) { { first_name: "xxxxx", email: Faker::Internet.email, phone_number: "xxxxxxx", school_id: school.id } }
    let(:json) { MultiJson.load(response.body) }

    it "creates a new user" do
      User.any_instance.should_receive(:sms_phone_verify_code)
      expect { post :create, user: user_hash }.to change(User, :count).by(1)
    end

    it "should be successful" do
      User.any_instance.should_receive(:sms_phone_verify_code)
      post :create, user: user_hash
      response.should be_success
    end

    it "should return user object" do
      User.any_instance.should_receive(:sms_phone_verify_code)
      post :create, user: user_hash
      json.keys.should include("user")
      json["user"].keys.should include("auth_token", "id", "email", "phone_number")
    end

    context "invalid email" do
      before { user_hash[:email] = "xxxxx" }

      subject { response }

      it "should not create a new user" do
        expect { post :create, user: user_hash }.to_not change(User, :count).by(1)
      end

      it "should return error code" do
        post :create, user: user_hash
        subject.code.should == "422"
      end

      it "should return errors" do
        post :create, user: user_hash
        json.keys.should include("errors")
      end
    end
  end
end
