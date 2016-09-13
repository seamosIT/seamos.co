# == Schema Information
#
# Table name: usuarios
#
#  id                   :integer          not null, primary key
#  primer_apellido      :string
#  segundo_apellido     :string
#  nombres              :string
#  tipo_de_documento_id :integer
#  numero_documento     :string           not null
#  fecha_expedicion     :date
#  role_id              :integer
#  uid                  :string           not null
#  valido               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Usuario < ApplicationRecord
  belongs_to :tipo_de_documento
  belongs_to :role

  has_many  :polls
  has_many  :votes

  validates  :primer_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :segundo_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :nombres, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates_presence_of  [:primer_apellido, :segundo_apellido, :nombres, :numero_documento]
  validates :numero_documento, numericality: { only_integer: true }, uniqueness: true
  validate :fecha_de_expedicion_razonable

  def fecha_de_expedicion_razonable
    if fecha_expedicion > Date.today
      #TODO change to Format I18n Rails errors Message
      errors.add(:fecha_expedicion, I18n.t(:fecha_invalida))
    end
  end

  def full_name
    "#{nombres} #{primer_apellido} #{segundo_apellido}"
  end

  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

end
