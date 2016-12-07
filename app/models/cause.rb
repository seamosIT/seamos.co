# == Schema Information
#
# Table name: causes
#
#  id             :integer          not null, primary key
#  description    :text             not null
#  title          :string           not null
#  state_cause_id :integer          not null
#  usuario_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Cause < ApplicationRecord
  belongs_to :usuario

  validates_presence_of  [:description, :title]
end