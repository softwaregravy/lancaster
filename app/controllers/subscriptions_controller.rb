class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource 

  def index
  end

  def new
    if current_user.admin?
      @current_feeds = []
      @current_web_pages = []
    else
      @current_feeds = current_user.subscriptions.where(subscribable_type: "Feed").pluck(:subscribable_id)
      @current_web_pages = current_user.subscriptions.where(subscribable_type: "WebPage").pluck(:subscribable_id)
    end
    @feeds = Feed.accessible_by(current_ability)
    @web_pages = WebPage.accessible_by(current_ability)
  end

  def create
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscriptions_path, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: subscriptions_path }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :subscribable_id, :subscribable_type, :notification_preference)
    end
end
