require 'rails_helper'

RSpec.describe "candidates/index", type: :view do
  before(:each) do
    assign(:candidates, [
      Candidate.create!(
        :name => "Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :resume => "Resume"
      ),
      Candidate.create!(
        :name => "Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :resume => "Resume"
      )
    ])
  end

  it "renders a list of candidates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Resume".to_s, :count => 2
  end
end
