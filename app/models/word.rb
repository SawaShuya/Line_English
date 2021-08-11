class Word < ApplicationRecord
  belongs_to :list

  validates :english, presence: true
  validates :japanese, presence: true
end
