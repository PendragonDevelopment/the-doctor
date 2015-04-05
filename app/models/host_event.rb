# == Schema Information
#
# Table name: host_events
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  host_id    :integer
#  rate       :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_host_events_on_event_id  (event_id)
#  index_host_events_on_host_id   (host_id)
#

class HostEvent < ActiveRecord::Base

  belongs_to :event
  belongs_to :host

  def create_schedule(params)

    conn = Faraday.new(:url => "http://tardis-scheduler.herokuapp.com") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    conn.post do |req|
      req.url "/schedule_blocks"
      req.params = params
    end

  end
end
