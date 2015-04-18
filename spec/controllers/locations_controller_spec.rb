require 'rails_helper'

describe LocationsController, type: :controller do
	
	describe 'GET #index' do
		
		it "populates an array of all locations" do
			highland_games = create(:location, title: "Highland Games")
			olympics = create(:location, title: "Olympics")
			get :index
			expect(assigns(:locations)).to match_array([highland_games, olympics])
		end

		it "renders the :index template" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do

		it "assigns the requested location to @location" do
			location = create(:location)
			get :show, id: location
			expect(assigns(:location)).to eq location
		end

		it "renders the :show template" do
			location = create(:location)
			get :show, id: location
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		
		it "assigns a new location to @location" do
			get :new
			expect(assigns(:location)).to be_a_new(location)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do

		it "assigns the requested location to @location" do
			location = create(:location)
			get :edit, id: location
			expect(assigns(:location)).to eq location
		end
		
		it "renders the :edit template" do
			location = create(:location)
			get :edit, id: location
			expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do

		context 'with valid attributes' do

			it "saves the new location in the database" do
				expect{
					post :create, location: attributes_for(:location)
				}.to change(location, :count).by(1)
			end

			it "redirects to locations#show" do
				post :create, location: attributes_for(:location)
				expect(response).to redirect_to contact_path(assigns[:location])
			end
		end

		context 'with invalid attributes' do

			it "does not save the new location in the database" do
				expect {
					post :create, location: attributes_for(:invalid_location)
				}.not_to change(location, :count)
			end

			it "re-renders the :new template" do
				post :create, location: attributes_for(:invalid_location)
				expect(response).to render_template :new
			end
		end
	end

	describe 'PATCH #update' do
		before(:each) do
			@location = create(:location, title: "home")
		end
		
		context 'with valid attributes' do
			
			it "locates the requested @location" do
				patch :update, id: @location, location: attributes_for(:location)
				expect(assigns(:location)).to eq(@location)
			end
			
			it "updates the location in the database" do
				patch :update, id: @location, location: attributes_for(:location, title: "Dad's House")
				@location.reload
				expect(@location.title).to eq("Dad's House")
			end
			
			it "redirects to the location" do
				patch :update, id: @location, location: attributes_for(:location)
				expect(response).to redirect_to @location
			end
		end

		context 'with invalid attributes' do
			
			it "does not update the location" do
				patch :update, id: @location, location: attributes_for(:invalid_location)
				@location.reload
				expect(@location.title).to eq("home")
			end

			it "re-renders the :edit template" do
				patch :update, id: @location, location: attributes_for(:invalid_location)
				expect(response).to render_template :edit
			end

		end
	end

	describe 'DELETE #destroy' do
		before(:each) do
			@location = FactoryGirl.create(:location)
		end

		it "deletes the location from the database" do
			expect {
				delete :destroy, id: @location
			}.to change(Location, :count).by(-1)
		end

		it "redirects to root path" do
			delete :destroy, id: @location
			expect(response).to redirect_to root_url
		end
	end
end