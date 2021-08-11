class List < ApplicationRecord
  has_many :words, dependent: :destroy
  belongs_to :user

  varidates :title, presence: true
end
