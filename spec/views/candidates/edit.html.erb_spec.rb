require 'rails_helper'

RSpec.describe "candidates/edit", type: :view do
  before(:each) do
    @candidate = assign(:candidate, Candidate.create!(
      :name => "MyString",
      :phone_number => "MyString",
      :email => "MyString",
      :resume => "MyString"
    ))
  end

  it "renders the edit candidate form" do
    render

    assert_select "form[action=?][method=?]", candidate_path(@candidate), "post" do

      assert_select "input[name=?]", "candidate[name]"

      assert_select "input[name=?]", "candidate[phone_number]"

      assert_select "input[name=?]", "candidate[email]"

      assert_select "input[name=?]", "candidate[resume]"
    end
  end
end
