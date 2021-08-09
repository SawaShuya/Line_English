class List < ApplicationRecord
  has_many :words, dependent: :destroy
end
