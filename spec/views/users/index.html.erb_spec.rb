require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
           FactoryGirl.create(:user),
           FactoryGirl.create(:user)
    ])
  end

  it "renders a list of users" do
    pending "do this better"
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
  end
end
