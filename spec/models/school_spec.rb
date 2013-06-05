require "spec_helper"

describe School do
  describe ".near" do
    let!(:palo_alto_school) { FactoryGirl.create(:school, coordinates: [-122.143256, 37.441405]) }
    let(:lat) { 37.440008 }
    let(:lon) { -122.144243 }

    subject { School.near(lat, lon) }

    it "should return school near Palo Alto" do
      subject.first.id.should == palo_alto_school.id
    end
  end
end
