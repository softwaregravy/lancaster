require 'rails_helper'

RSpec.describe "web_pages/edit", type: :view do
  before(:each) do
    @web_page = assign(:web_page, create(:web_page))
    @admin = create(:admin)
    sign_in @admin 
  end

  it "renders the edit web_page form" do
    render

    assert_select "form[action=?][method=?]", web_page_path(@web_page), "post" do

      assert_select "input#web_page_url[name=?]", "web_page[url]"
    end
  end
end
