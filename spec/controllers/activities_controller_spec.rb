require 'rails_helper'

describe ActivitiesController, type: :controller do
	
	describe 'GET #index' do
		it "populates an array of all activities"
		it "renders the :index template"
	end

	describe 'GET #show' do
		it "assigns the requested activity to @activity"
		it "renders the :show template"
	end

	describe 'GET #new' do
		it "assigns a new activity to @activity"
		it "renders the :new template"
	end

	describe 'GET #edit' do
		it "assigns the requested activity to @activity"
		it "renders the :edit template"
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it "saves the new activity in the database"
			it "redirects to activities#show"
		end

		context 'with invalid attributes' do
			it "does not save the new activity in the database"
			it "re-renders the :new template"
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it "updates the activity in the database"
			it "redirects to the activity"
		end

		context 'with invalid attributes' do
			it "does not update the contact"
			it "re-renders the :edit template"
		end
	end

	describe 'DELETE #destroy' do
		before(:each) do
			@activity = FactoryGirl.create(:activity)
		end

		it "deletes the activity from the database" do
			expect {
				delete :destroy, id: @activity
			}.to change(Activity, :count).by(-1)
		end

		it "redirects to root path" do
			delete :destroy, id: @activity
			expect(response).to redirect_to root_url
		end
	end
end