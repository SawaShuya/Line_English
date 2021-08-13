class List < ApplicationRecord
  has_many :words, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

  def last_update
    time = self.updated_at
    if self.words.present?
      if time < self.words.maximum("updated_at")
        time = self.words.maximum("updated_at")
      end
    end
    
    return time
  end
end
