require 'rails_helper'

RSpec.describe FeedsController, type: :controller do

  let(:valid_attributes) { FactoryGirl.attributes_for(:feed) }
  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:feed).merge(url: "definitely not a valid url")
  }

  before do 
    @admin = FactoryGirl.create(:admin)
    sign_in @admin 
    @feed = FactoryGirl.create(:feed)
  end

  describe "GET #index" do
    it "assigns all feeds as @feeds" do
      get :index, {}
      expect(assigns(:feeds)).to eq([@feed])
    end
  end

  describe "GET #show" do
    it "assigns the requested feed as @feed" do
      get :show, {:id => @feed.to_param}
      expect(assigns(:feed)).to eq(@feed)
    end
  end

  describe "GET #new" do
    it "assigns a new feed as @feed" do
      get :new, {}
      expect(assigns(:feed)).to be_a_new(Feed)
    end
  end

  describe "GET #edit" do
    it "assigns the requested feed as @feed" do
      get :edit, {:id => @feed.to_param}
      expect(assigns(:feed)).to eq(@feed)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Feed" do
        expect {
          post :create, {:feed => valid_attributes}
        }.to change(Feed, :count).by(1)
      end
      it "assigns a newly created feed as @feed" do
        post :create, {:feed => valid_attributes}
        expect(assigns(:feed)).to be_a(Feed)
        expect(assigns(:feed)).to be_persisted
      end
      it "redirects to the created feed" do
        post :create, {:feed => valid_attributes}
        expect(response).to redirect_to(Feed.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved feed as @feed" do
        expect {
          post :create, {:feed => invalid_attributes}
        }.not_to change(Feed, :count)
      end
      it "re-renders the 'new' template" do
        post :create, {:feed => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before do 
        @old_url = @feed.url
        #paranoid about Faker giving us 2 of the same url
        loop do 
          @new_url = Faker::Internet.url
          break if @new_url != @old_url
        end
      end
      let(:new_attributes) {
        { url: @new_url }
      }
      it "updates the requested feed" do
        put :update, {:id => @feed.to_param, :feed => new_attributes}
        @feed.reload
        expect(@feed.url).to eq(@new_url)
      end
      it "assigns the requested feed as @feed" do
        put :update, {:id => @feed.to_param, :feed => valid_attributes}
        expect(assigns(:feed)).to eq(@feed)
      end
      it "redirects to the feed" do
        put :update, {:id => @feed.to_param, :feed => valid_attributes}
        expect(response).to redirect_to(@feed)
      end
    end

    context "with invalid params" do
      it "assigns the feed as @feed" do
        put :update, {:id => @feed.to_param, :feed => invalid_attributes}
        expect(assigns(:feed)).to eq(@feed)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => @feed.to_param, :feed => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested feed" do
      expect {
        delete :destroy, {:id => @feed.to_param}
      }.to change(Feed, :count).by(-1)
    end

    it "redirects to the feeds list" do
      delete :destroy, {:id => @feed.to_param}
      expect(response).to redirect_to(feeds_url)
    end
  end

end
