require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    context "when not signed in" do 
      it "does not give access" do
        get users_path
        expect(response).to have_http_status(302)
      end
    end 
  end
end
