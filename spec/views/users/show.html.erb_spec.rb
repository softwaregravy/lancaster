require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@user.email)
    expect(rendered).to match(Regexp.quote(@user.phone_number))
  end
end
