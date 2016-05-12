require 'rails_helper'

RSpec.describe WebPagesController, type: :controller do

  let(:valid_attributes) { attributes_for :web_page }

  let(:invalid_attributes) { attributes_for :web_page, url: "doh! not a url" }

  before do 
    @admin = create(:admin)
    sign_in @admin 
  end

  describe "GET #index" do

    it "assigns all web_pages as @web_pages" do
      web_page = create :web_page
      get :index, {}
      expect(assigns(:web_pages)).to eq([web_page])
    end
  end

  describe "GET #show" do
    it "assigns the requested web_page as @web_page" do
      web_page = create :web_page
      get :show, {:id => web_page.to_param}
      expect(assigns(:web_page)).to eq(web_page)
    end
  end

  describe "GET #new" do
    it "assigns a new web_page as @web_page" do
      get :new, {}
      expect(assigns(:web_page)).to be_a_new(WebPage)
    end
  end

  describe "GET #edit" do
    it "assigns the requested web_page as @web_page" do
      web_page = create :web_page
      get :edit, {:id => web_page.to_param}
      expect(assigns(:web_page)).to eq(web_page)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new WebPage" do
        expect {
          post :create, {:web_page => valid_attributes}
        }.to change(WebPage, :count).by(1)
      end

      it "assigns a newly created web_page as @web_page" do
        post :create, {:web_page => valid_attributes}
        expect(assigns(:web_page)).to be_a(WebPage)
        expect(assigns(:web_page)).to be_persisted
      end

      it "redirects to the created web_page" do
        post :create, {:web_page => valid_attributes}
        expect(response).to redirect_to(WebPage.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved web_page as @web_page" do
        post :create, {:web_page => invalid_attributes}
        expect(assigns(:web_page)).to be_a_new(WebPage)
      end

      it "re-renders the 'new' template" do
        post :create, {:web_page => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for :web_page }

      it "updates the requested web_page" do
        web_page = create :web_page
        put :update, {:id => web_page.to_param, :web_page => new_attributes}
        web_page.reload
        web_page.url.should == new_attributes[:url]
      end

      it "assigns the requested web_page as @web_page" do
        web_page = create :web_page
        put :update, {:id => web_page.to_param, :web_page => valid_attributes}
        expect(assigns(:web_page)).to eq(web_page)
      end

      it "redirects to the web_page" do
        web_page = create :web_page
        put :update, {:id => web_page.to_param, :web_page => valid_attributes}
        expect(response).to redirect_to(web_page)
      end
    end

    context "with invalid params" do
      it "assigns the web_page as @web_page" do
        web_page = create :web_page
        put :update, {:id => web_page.to_param, :web_page => invalid_attributes}
        expect(assigns(:web_page)).to eq(web_page)
      end

      it "re-renders the 'edit' template" do
        web_page = create :web_page
        put :update, {:id => web_page.to_param, :web_page => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested web_page" do
      web_page = create :web_page
      expect {
        delete :destroy, {:id => web_page.to_param}
      }.to change(WebPage, :count).by(-1)
    end

    it "redirects to the web_pages list" do
      web_page = create :web_page
      delete :destroy, {:id => web_page.to_param}
      expect(response).to redirect_to(web_pages_url)
    end
  end

end
