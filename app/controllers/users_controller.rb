class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id, only: :show
  load_and_authorize_resource 

  def index
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.require(:user).permit(:email, :phone_number, :password, :password_confirmation)
      # email and password must be edited via devise controller
      params.require(:user).permit(:phone_number, :notifications_enabled)
    end

    def set_user_id
      # in the case that #show is the root
      params[:id] ||= current_user.id 
    end

end
