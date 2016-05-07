require 'rails_helper'

RSpec.describe RefreshFeedsWorker do
  describe "#perform" do 
    before { create (:feed) }
    it "should send fetch to each feed" do 
      expect_any_instance_of(Feed).to receive(:fetch_latest_post).with(true)
      RefreshFeedsWorker.new.perform
    end
  end
end
