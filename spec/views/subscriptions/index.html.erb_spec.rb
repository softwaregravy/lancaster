require 'rails_helper'

RSpec.describe "subscriptions/index", type: :view do
  before(:each) do
    @user = create :user
    sign_in @user

    assign(:subscriptions, [
           @s1 = create(:subscription, user: @user),
    ])
  end

  it "renders a list of subscriptions" do
    render
    assert_select "tr>td", :text => @s1.user.email
    assert_select "tr>td", :text => @s1.subscribable.display_name
  end
end
