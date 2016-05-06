require 'rails_helper'

RSpec.describe "subscriptions/index", type: :view do
  before(:each) do
    assign(:subscriptions, [
           @s1 = FactoryGirl.create(:subscription),
           @s2 = FactoryGirl.create(:subscription)
    ])
  end

  it "renders a list of subscriptions" do
    render
    assert_select "tr>td", :text => @s1.user.email
    assert_select "tr>td", :text => @s1.feed.name
    assert_select "tr>td", :text => @s2.user.email
    assert_select "tr>td", :text => @s2.feed.name
  end
end
