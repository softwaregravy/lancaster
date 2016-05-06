require 'rails_helper'

RSpec.describe "feeds/show", type: :view do
  before(:each) do
    @feed = assign(:feed, FactoryGirl.create(:feed))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
  end
end
