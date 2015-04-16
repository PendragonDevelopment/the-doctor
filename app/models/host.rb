class Host < ActiveRecord::Base
  belongs_to :user
  has_many :events
  has_many :activites, through: :events
end
