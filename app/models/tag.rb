# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :polls, -> { distinct }, through: :taggings
  validates :name, presence: true, uniqueness: true
end
