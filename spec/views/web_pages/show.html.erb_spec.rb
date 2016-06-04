require 'rails_helper'

RSpec.describe "web_pages/show", type: :view do
  before(:each) do
    @web_page = assign(:web_page, create(:web_page))
    @admin = create(:admin)
    sign_in @admin 
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
  end
end
