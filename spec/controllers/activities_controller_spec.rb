require 'rails_helper'

describe ActivitiesController, type: :controller do
	
	describe 'GET #index' do
		
		it "populates an array of all activities" do
			highland_games = create(:activity, title: "Highland Games")
			olympics = create(:activity, title: "Olympics")
			get :index
			expect(assigns(:activities)).to match_array([highland_games, olympics])
		end

		it "renders the :index template" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do

		it "assigns the requested activity to @activity" do
			activity = create(:activity)
			get :show, id: activity
			expect(assigns(:activity)).to eq activity
		end

		it "renders the :show template" do
			activity = create(:activity)
			get :show, id: activity
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		
		it "assigns a new activity to @activity" do
			get :new
			expect(assigns(:activity)).to be_a_new(Activity)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do

		it "assigns the requested activity to @activity" do
			activity = create(:activity)
			get :edit, id: activity
			expect(assigns(:activity)).to eq activity
		end
		
		it "renders the :edit template" do
			activity = create(:activity)
			get :edit, id: activity
			expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do

		context 'with valid attributes' do

			it "saves the new activity in the database" do
				expect{
					post :create, activity: attributes_for(:activity)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to activities#show" do
				post :create, activity: attributes_for(:activity)
				expect(response).to redirect_to activity_path(assigns[:activity])
			end
		end

		context 'with invalid attributes' do

			it "does not save the new activity in the database" do
				expect {
					post :create, activity: attributes_for(:invalid_activity)
				}.not_to change(Activity, :count)
			end

			it "re-renders the :new template" do
				post :create, activity: attributes_for(:invalid_activity)
				expect(response).to render_template :new
			end
		end
	end

	describe 'PATCH #update' do
		before(:each) do
			@activity = create(:activity, title: "Juggling")
		end
		
		context 'with valid attributes' do
			
			it "locates the requested @activity" do
				patch :update, id: @activity, activity: attributes_for(:activity)
				expect(assigns(:activity)).to eq(@activity)
			end
			
			it "updates the activity in the database" do
				patch :update, id: @activity, activity: attributes_for(:activity, title: "Swimming")
				@activity.reload
				expect(@activity.title).to eq("Swimming")
			end
			
			it "redirects to the activity" do
				patch :update, id: @activity, activity: attributes_for(:activity)
				expect(response).to redirect_to @activity
			end
		end

		context 'with invalid attributes' do
			
			it "does not update the activity" do
				patch :update, id: @activity, activity: attributes_for(:invalid_activity)
				@activity.reload
				expect(@activity.title).to eq("Juggling")
			end

			it "re-renders the :edit template" do
				patch :update, id: @activity, activity: attributes_for(:invalid_activity)
				expect(response).to render_template :edit
			end

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