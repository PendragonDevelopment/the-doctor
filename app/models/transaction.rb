class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :host_event
  enum status: [:payment_pending, :paid]

end
