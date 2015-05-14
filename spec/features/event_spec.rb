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

feature "Host creates an Event" do
  background :each do
    host = create(:host)
    sign_in host.user
    @activity = create(:activity)
    @location = create(:location)
  end

  scenario 'host accesses create new event form' do
    click_link 'Events'
    click_link 'Create New Event'
    expect(page).to have_content 'Create a New Event'
  end

  scenario 'host creates an event with an existing location and activity' do
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 25)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'host creates an event with a new location created in the form' do 
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    fill_in('or create a new location:', with: 'New Location Capybara')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'host creates an event with a new activity created in the form' do 
    visit '/events/new'
    fill_in('or create a new activity:', with: 'New Activity Capybara')
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'host creates an event with an existing location typed into new location field' do
    visit '/events/new'
    select(@activity.title, from: 'Activity')
    fill_in('or create a new location:', with: @location.title)
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end

  scenario 'host creates an event with an exisiting activity typed into new activity field' do 
    visit '/events/new'
    fill_in('or create a new activity:', with: @activity.title)
    select(@location.title, from: 'Location')
    fill_in('Event rate', with: 35)
    click_button 'Create Event'
    expect(page).to have_content 'Create a New Event Instance'
  end
end

feature 'Host edits an Event' do 
  background :each do 
    host = create(:host)
    sign_in host.user
    @event = create(:event) 
  end

  scenario 'host changes Event activity to a different exisiting activity' do
    new_activity = create(:activity, title: 'New Test Activity')
    visit "/events/#{@event.id}/edit"
    select('New Test Activity', from: 'Activity')
    click_button 'Update Event'
    expect(page).to have_content 'Event succesfully updated'
  end

  scenario 'host changes Event location to a different existing location' do 
    new_location = create(:location, title: 'New Test Location')
    visit "/events/#{@event.id}/edit"
    select('New Test Location', from: 'Location')
    click_button 'Update Event'
    expect(page).to have_content 'Event succesfully updated'
  end

  scenario 'host changes Event location to a new location created in the form' do 
    visit "/events/#{@event.id}/edit"
    fill_in('or create a new location:', with: 'New Test Location')
    click_button 'Update Event'
    expect(page).to have_content 'Event succesfully updated'
  end

  scenario 'host changes Event activity to a new location created in the form' do 
    visit "/events/#{@event.id}/edit"
    fill_in('or create a new activity:', with: 'New Test Activity')
    click_button 'Update Event'
    expect(page).to have_content 'Event succesfully updated'
  end

end

feature 'Host deletes an Event' do 
  background :each do 
    host = create(:host)
    sign_in host.user
    @event = create(:event) 
  end

  scenario 'Host deletes an Event' do
    visit "/events/#{@event.id}" do
    click_link 'Delete Event'
    click_link 'Delete Event' # Not a duplicate, there is a confirmation page so this button is pushed twice
    expect(page).to have_content 'Event succesfully deleted'
    end
  end
end

feature 'Host creates a Schedule Block for an Event' do
  background :each do 
    host = create(:host)
    sign_in host.user
    @event = create(:event)
  end

  scenario 'Host creates a Schedule Block' do
    visit "/events/#{@event.id}/new_schedule_block"
    select('2015', from: '_start_time_1i')
    select('June', from: '_start_time_2i')
    select('15', from: '_start_time_3i')
    select('12 PM', from: '_start_time_4i')
    select('00', from: '_start_time_5i')
    select('2015', from: '_end_time_1i')
    select('June', from: '_end_time_2i')
    select('15', from: '_end_time_3i')
    select('01 PM', from: '_end_time_4i')
    select('00', from: '_end_time_5i')
    fill_in('Reservation min', with: 1)
    fill_in('Reservation min', with: 10)
    click_button 'Create Event Instance'
    expect(page).to have_content 'Schedule block succesfully created'
  end
end

# The rest of the tests for Schedule Blocks are in spec/requests/api/v1/schedule_blocks_specs.rb




