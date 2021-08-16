class Word < ApplicationRecord
  belongs_to :list
  has_many :questions

  validates :english, presence: true
  validates :japanese, presence: true
end
