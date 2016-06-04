require "rails_helper"

RSpec.describe WebPagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/web_pages").to route_to("web_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/web_pages/new").to route_to("web_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/web_pages/1").to route_to("web_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/web_pages/1/edit").to route_to("web_pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/web_pages").to route_to("web_pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/web_pages/1").to route_to("web_pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/web_pages/1").to route_to("web_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/web_pages/1").to route_to("web_pages#destroy", :id => "1")
    end

  end
end
