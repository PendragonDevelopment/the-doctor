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
  let(:host_event) {FactoryGirl.create(:host_event)}

  describe "Model attributes set up" do
  	subject {host_event}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:event_id)}
  	it {is_expected.to respond_to(:host_id)}
  	it {is_expected.to respond_to(:rate)}
  	it {is_expected.to respond_to(:created_at)}
  	it {is_expected.to respond_to(:updated_at)}

  	it {is_expected.to be_valid}
  end
end
