require 'rails_helper'

# ===============================================
# Example syntax

feature 'my feature' do 
  background do 
    # add setup details
  end

  scenario 'my first test' do 
    # write the example!
  end
end 

# ===============================================

feature "Event creation" do
  background :each do
    host = create(:host)
    sign_in host.user
    @activity = create(:activity)
    @location = create(:location)
  end

  scenario 'user accesses create new event form' do
    click_link 'Events'
    click_link 'Create New Event'
    expect(page).to have_content 'Create a New Event'
  end

  scenario 'user creates an event with an existing location and activity' do
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 25)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'user creates an event with a new location' do 
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    fill_in('or create a new location:', with: 'New Location Capybara')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'user creates an event with a new activity' do 
    visit '/events/new'
    fill_in('or create a new activity:', with: 'New Activity Capybara')
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'user creates an event with an existing location typed into new location field' do
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    fill_in('or create a new location:', with: @location.title)
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'user creates an event with an exisiting activity typed into new activity field' do 
    visit '/events/new'
    fill_in('or create a new activity:', with: @activity.title)
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end


end


