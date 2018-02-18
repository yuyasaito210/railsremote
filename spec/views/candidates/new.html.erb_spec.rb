require 'rails_helper'

RSpec.describe "candidates/new", type: :view do
  before(:each) do
    assign(:candidate, Candidate.new(
      :name => "MyString",
      :phone_number => "MyString",
      :email => "MyString",
      :resume => "MyString"
    ))
  end

  it "renders new candidate form" do
    render

    assert_select "form[action=?][method=?]", candidates_path, "post" do

      assert_select "input[name=?]", "candidate[name]"

      assert_select "input[name=?]", "candidate[phone_number]"

      assert_select "input[name=?]", "candidate[email]"

      assert_select "input[name=?]", "candidate[resume]"
    end
  end
end
