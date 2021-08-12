class List < ApplicationRecord
  has_many :words, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
end
