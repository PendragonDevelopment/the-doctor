# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) {FactoryGirl.create(:event)}

  describe "Model attributes set up" do
  	subject {event}

  	it {is_expected.to respond_to(:title)}

  	it {is_expected.to be_valid}
  end
end
