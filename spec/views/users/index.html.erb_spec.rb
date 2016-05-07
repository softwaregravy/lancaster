require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    sign_in create(:admin)
    assign(:users, [
           @user1 = create(:user),
           @user2 = create(:user)
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => @user1.email
    assert_select "tr>td", :text => @user2.email
  end
end
