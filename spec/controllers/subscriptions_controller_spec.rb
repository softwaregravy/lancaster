require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  before do 
    @user = create(:user)
    @feed = create(:feed)
    sign_in @user
  end

  let(:valid_attributes) { attributes_for(:subscription, user_id: @user.id, feed_id: @feed.id) }

  let(:invalid_attributes) { {user_id: @user.id, feed_id: -1} }

  describe "GET #index" do
    it "assigns all subscriptions as @subscriptions" do
      subscription = Subscription.create! valid_attributes
      get :index, {}
      expect(assigns(:subscriptions)).to eq([subscription])
    end
  end

  describe "GET #new" do
    before do 
      @feed2 = create(:feed)
    end
    it "assigns a new subscription as @subscription" do
      get :new, {}
      expect(assigns(:subscription)).to be_a_new(Subscription)
    end
    it "assigns current feed ids to @current_feeds" do 
      Subscription.create! valid_attributes
      get :new, {}
      expect(assigns(:current_feeds)).to eq([@feed.id])
    end
    context "as an admin" do 
      before do 
        @admin = create(:admin)
        sign_in @admin
      end
      it "remembers no feeds" do 
        # and thus allows admins to assign any feed to any user
        create(:subscription, user: @admin)
        get :new
        expect(assigns(:current_feeds)).to eq([])
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, {:subscription => valid_attributes}
        }.to change(Subscription, :count).by(1)
      end

      it "assigns a newly created subscription as @subscription" do
        post :create, {:subscription => valid_attributes}
        expect(assigns(:subscription)).to be_a(Subscription)
        expect(assigns(:subscription)).to be_persisted
      end

      it "redirects to the created subscription" do
        post :create, {:subscription => valid_attributes}
        expect(response).to redirect_to(subscriptions_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved subscription as @subscription" do
        expect {
          post :create, {:subscription => invalid_attributes}
        }.not_to change(Subscription, :count)
      end
      it "re-renders the 'new' template" do
        post :create, {:subscription => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested subscription" do
      subscription = Subscription.create! valid_attributes
      expect {
        delete :destroy, {:id => subscription.to_param}
      }.to change(Subscription, :count).by(-1)
    end

    it "redirects to the subscriptions list" do
      subscription = Subscription.create! valid_attributes
      delete :destroy, {:id => subscription.to_param}
      expect(response).to redirect_to(subscriptions_url)
    end
  end

end
