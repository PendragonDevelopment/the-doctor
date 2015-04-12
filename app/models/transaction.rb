class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :host_event
end
