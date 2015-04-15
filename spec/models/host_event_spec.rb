# == Schema Information
#
# Table name: host_events
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  host_id    :integer
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe HostEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
