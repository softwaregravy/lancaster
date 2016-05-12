require 'rails_helper'

RSpec.describe "web_pages/new", type: :view do
  before(:each) do
    @admin = create(:admin)
    sign_in @admin 
    assign(:web_page, create(:web_page))
  end

  #it "renders new web_page form" do
    #render
    #assert_select "form[action=?][method=?]", web_pages_path, "post" do
      #assert_select "input#web_page_url[name=?]", "web_page[url]"
    #end
  #end
end
