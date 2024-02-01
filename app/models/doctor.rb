class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments, dependent: :destroy

  validates :first_name, :last_name, :specialization, :image, :bio, :fee, presence: true
end
