require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @original_number = "555-555-5555"
    @user = create(:user, phone_number: @original_number)
    @admin = create(:admin, phone_number: @original_number) 
    # other users
  end

  describe "GET #index" do
    context "as user" do 
      before { sign_in @user }
      it "assigns visible users as @users" do
        get :index, {}
        expect(assigns(:users)).to eq([@user])
      end
    end
    context "as admin" do
      before { sign_in @admin }
      it "assigns all users to @users" do
        get :index, {}
        expect(assigns(:users)).to match_array([@user, @admin])
      end
    end
    context "when not logged in" do 
      it "redircts to login page" do
        get :index, {}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "as user" do 
      before { sign_in @user }
      it "assigns self as @user" do
        get :show, {:id => @user.to_param}
        expect(assigns(:user)).to eq(@user)
      end
      it "assigns self as @user when no params are passed" do
        get :show
        expect(assigns(:user)).to eq(@user)
      end
      it "redirects away when another user is requsted" do
        get :show, {:id => @admin.to_param}
        response.should be_redirect
      end
    end
    context "as admin" do
      before { sign_in @admin }
      it "assigns self as @user" do
        get :show, {:id => @admin.to_param}
        expect(assigns(:user)).to eq(@admin)
      end
      it "assigns other users to @user" do
        get :show, {:id => @user.to_param}
        expect(assigns(:user)).to eq(@user)
      end
    end
    context "when not logged in" do 
      it "redirects to login page" do 
        get :show, {:id => @user.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    context "as user" do 
      before { sign_in @user }
      it "assigns self as @user" do
        get :edit, {:id => @user.to_param}
        expect(assigns(:user)).to eq(@user)
      end
      it "redirects away when another user is requested" do 
        get :edit, {:id => @admin.to_param}
        response.should be_redirect
      end
    end
    context "as admin" do
      before { sign_in @admin }
      it "assigns self as @user" do
        get :edit, {:id => @admin.to_param}
        expect(assigns(:user)).to eq(@admin)
      end
      it "assigns other user to @user" do
        get :edit, {:id => @user.to_param}
        expect(assigns(:user)).to eq(@user)
      end
    end
    context "as not logged in" do
      it "redirects away" do 
        get :edit, {:id => @user.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT #update" do
    before do 
      @new_number = "555-555-5556"
    end
    it "should be a sane test" do 
      pnf = PhoneNumberFormatter
      pnf.format(@original_number).should_not == pnf.format(@new_number)
      pnf.format(@user.phone_number).should == pnf.format(@original_number)
      pnf.format(@admin.phone_number).should == pnf.format(@original_number)
    end
    let(:new_attributes) { {phone_number: @new_number, notifications_enabled: true} }
    let(:invalid_attributes) { {phone_number: '345'} }
    context "as user" do 
      before { sign_in @user }
      context "with valid params" do
        it "updates the requested user" do
          put :update, {:id => @user.to_param, :user => new_attributes}
          @user.reload
          expect(@user.phone_number).to eql(PhoneNumberFormatter.format(@new_number))
        end
        it "assigns the requested user as @user" do
          put :update, {:id => @user.to_param, :user => new_attributes}
          expect(assigns(:user)).to eq(@user)
        end
        it "redirects to the user" do
          put :update, {:id => @user.to_param, :user => new_attributes}
          expect(response).to redirect_to(@user)
        end
        it "does not update other users" do 
          put :update, {:id => @admin.to_param, :user => new_attributes}
          @user.reload
          expect(@user.phone_number).to eql(PhoneNumberFormatter.format(@original_number))
        end
      end
      context "with invalid params" do
        it "assigns the user as @user" do
          put :update, {:id => @user.to_param, :user => invalid_attributes}
          expect(assigns(:user)).to eq(@user)
        end
        it "re-renders the 'edit' template" do
          put :update, {:id => @user.to_param, :user => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
    context "as admin" do 
      before { sign_in @admin}
      context "with valid params" do
        it "updates the requested user" do
          put :update, {:id => @admin.to_param, :user => new_attributes}
          @admin.reload
          expect(@admin.phone_number).to eql(PhoneNumberFormatter.format(@new_number))
        end
        it "updates other users" do 
          put :update, {:id => @user.to_param, :user => new_attributes}
          @user.reload
          expect(@user.phone_number).to eql(PhoneNumberFormatter.format(@new_number))
        end
      end
    end
    context "as not logged in" do
      it "does not updates the requested user" do
        put :update, {:id => @admin.to_param, :user => new_attributes}
        @admin.reload
        expect(@admin.phone_number).to eql(PhoneNumberFormatter.format(@original_number))
      end
      it "redirects to the login page" do
        put :update, {:id => @user.to_param, :user => new_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "as user" do 
      before { sign_in @user }
      it "destroys the requested user" do
        expect {
          delete :destroy, {:id => @user.to_param}
        }.to change(User, :count).by(-1)
      end
      it "does not destroy other requested user" do
        expect {
          delete :destroy, {:id => @admin.to_param}
        }.to_not change(User, :count)
      end
      it "redirects to the users list" do
        delete :destroy, {:id => @user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end
    context "as admin" do 
      before { sign_in @admin }
      it "destroys the requested user" do
        expect {
          delete :destroy, {:id => @user.to_param}
        }.to change(User, :count).by(-1)
      end
      it "redirects to the users list" do
        delete :destroy, {:id => @user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end
  end
  context "as not logged in" do 
    it "does not destroy other requested user" do
      expect {
        delete :destroy, {:id => @admin.to_param}
      }.to_not change(User, :count)
    end
    it "redirects to the login page" do
      delete :destroy, {:id => @user.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end

