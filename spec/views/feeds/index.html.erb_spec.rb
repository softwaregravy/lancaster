require 'rails_helper'

RSpec.describe "feeds/index", type: :view do
  before(:each) do
    assign(:feeds, [
           @feed1 = create(:feed),
    ])
  end

  it "renders a list of feeds" do
    render
    assert_select "tr>td", :text => @feed1.display_name
    assert_select "tr>td", :text => @feed1.url
  end
end
