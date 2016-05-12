require 'rails_helper'

RSpec.describe "web_pages/index", type: :view do
  before(:each) do
    @admin = create(:admin)
    sign_in @admin 
    assign(:web_pages, [
           @wb1 = create(:web_page),
           @wb2 = create(:web_page)
    ])
  end

  it "renders a list of web_pages" do
    render
    assert_select "tr>td", :text => @wb1.url
    assert_select "tr>td", :text => @wb2.url
  end
end
