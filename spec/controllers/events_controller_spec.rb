require 'rails_helper'

describe EventsController, type: :controller do
	
	describe 'GET #index' do
		it "populates an array of all events"
		it "renders the :index template"
	end

	describe 'GET #show' do
		it "assigns the requested event to @event"
		it "renders the :show template"
	end

	describe 'GET #new' do
		it "assigns a new Event to @event"
		it "renders the :new template"
	end

	describe 'GET #edit' do
		it "assigns the requested event to @event"
		it "renders the :edit template"
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it "saves the new event in the database"
			it "redirects to events#show"
		end

		context 'with invalid attributes' do
			it "does not save the new event in the database"
			it "re-renders the :new template"
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it "updates the event in the database"
			it "redirects to the event"
		end

		context 'with invalid attributes' do
			it "does not update the contact"
			it "re-renders the :edit template"
		end
	end

	describe 'DELETE #destroy' do
		it "deletes the event from the database"
		it "redirects to root path"
	end
end