module ScheduleBlockHelper

  def create_schedule_block
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
  end

end
