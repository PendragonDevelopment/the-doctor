# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  rating         :integer
#  active         :boolean
#  bio            :string
#  user_id        :integer
#  birthdate      :date
#  status         :integer
#  resume         :string
#  direct_deposit :string
#  voided_check   :string
#  w9             :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Host < ActiveRecord::Base
  belongs_to :user
  has_many :events
  has_many :activites, through: :events
  ratyrate_rateable "quality"
end
