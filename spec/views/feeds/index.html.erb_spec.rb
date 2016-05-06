require 'rails_helper'

RSpec.describe "feeds/index", type: :view do
  before(:each) do
    assign(:feeds, [
           @feed1 = FactoryGirl.create(:feed),
           @feed2 = FactoryGirl.create(:feed)
    ])
  end

  it "renders a list of feeds" do
    render
    assert_select "tr>td", :text => @feed1.name
    assert_select "tr>td", :text => @feed1.url
    assert_select "tr>td", :text => @feed2.name
    assert_select "tr>td", :text => @feed2.url
  end
end
