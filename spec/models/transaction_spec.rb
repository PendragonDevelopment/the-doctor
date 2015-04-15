# == Schema Information
#
# Table name: transactions
#
#  id                 :integer          not null, primary key
#  title              :string
#  payment_amount     :integer
#  payment_date       :date
#  status             :integer
#  transaction_record :string
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appointment_id     :integer
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
