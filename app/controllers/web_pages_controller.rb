class WebPagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @web_page.save
        format.html { redirect_to @web_page, notice: 'Web page was successfully created.' }
        format.json { render :show, status: :created, location: @web_page }
      else
        format.html { render :new }
        format.json { render json: @web_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @web_page.update(web_page_params)
        format.html { redirect_to @web_page, notice: 'Web page was successfully updated.' }
        format.json { render :show, status: :ok, location: @web_page }
      else
        format.html { render :edit }
        format.json { render json: @web_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @web_page.destroy
    respond_to do |format|
      format.html { redirect_to web_pages_url, notice: 'Web page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def web_page_params
      params.require(:web_page).permit(:url)
    end
end
