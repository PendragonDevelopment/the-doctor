require 'rails_helper'

describe EventsController, type: :controller do
	
	describe 'GET #index' do
		
		it "populates an array of all events" do
			highland_games = create(:event, rate: 700)
			olympics = create(:event, rate: 600)
			get :index
			expect(assigns(:events)).to match_array([highland_games, olympics])
		end

		it "renders the :index template" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do

		it "assigns the requested event to @event" do
			event = create(:event)
			get :show, id: event
			expect(assigns(:event)).to eq event
		end

		it "renders the :show template" do
			event = create(:event)
			get :show, id: event
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		
		it "assigns a new Event to @event" do
			get :new
			expect(assigns(:event)).to be_a_new(Event)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do

		it "assigns the requested event to @event" do
			event = create(:event)
			get :edit, id: event
			expect(assigns(:event)).to eq event
		end
		
		it "renders the :edit template" do
			event = create(:event)
			get :edit, id: event
			expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do

		context 'with valid attributes' do

			it "saves the new event in the database" do
				expect{
					post :create, event: attributes_for(:event)
				}.to change(Event, :count).by(1)
			end

			it "redirects to events#show" do
				post :create, event: attributes_for(:event)
				expect(response).to redirect_to contact_path(assigns[:event])
			end
		end

		context 'with invalid attributes' do

			it "does not save the new event in the database" do
				expect {
					post :create, event: attributes_for(:invalid_event)
				}.not_to change(Event, :count)
			end

			it "re-renders the :new template" do
				post :create, event: attributes_for(:invalid_event)
				expect(response).to render_template :new
			end
		end
	end

	describe 'PATCH #update' do
		before(:each) do
			@event = create(:event, rate: 1)
		end
		
		context 'with valid attributes' do
			
			it "locates the requested @event" do
				patch :update, id: @event, event: attributes_for(:event)
				expect(assigns(:event)).to eq(@event)
			end
			
			it "updates the event in the database" do
				patch :update, id: @event, event: attributes_for(:event, rate: 30)
				@event.reload
				expect(@event.rate).to eq(30)
			end
			
			it "redirects to the event" do
				patch :update, id: @event, event: attributes_for(:event)
				expect(response).to redirect_to @event
			end
		end

		context 'with invalid attributes' do
			
			it "does not update the event" do
				patch :update, id: @event, event: attributes_for(:invalid_event)
				@event.reload
				expect(@event.rate).not_to be_nil
			end

			it "re-renders the :edit template" do
				patch :update, id: @event, event: attributes_for(:invalid_event)
				expect(response).to render_template :edit
			end

		end
	end

	describe 'DELETE #destroy' do
		before(:each) do
			@event = FactoryGirl.create(:event)
		end

		it "deletes the event from the database" do
			expect {
				delete :destroy, id: @event
			}.to change(Event, :count).by(-1)
		end

		it "redirects to root path" do
			delete :destroy, id: @event
			expect(response).to redirect_to root_url
		end
	end
end