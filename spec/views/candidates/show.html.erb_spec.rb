require 'rails_helper'

RSpec.describe "candidates/show", type: :view do
  before(:each) do
    @candidate = assign(:candidate, Candidate.create!(
      :name => "Name",
      :phone_number => "Phone Number",
      :email => "Email",
      :resume => "Resume"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Resume/)
  end
end
