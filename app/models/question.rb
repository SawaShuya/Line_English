class Question < ApplicationRecord
  belongs_to :user
  belongs_to :word

  def check_answer(answer)
    if self.word.japanese == answer
      self.update(is_collected: true)
    end
  end
end
