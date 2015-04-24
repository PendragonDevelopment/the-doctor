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

require 'rails_helper'

RSpec.describe HostEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
