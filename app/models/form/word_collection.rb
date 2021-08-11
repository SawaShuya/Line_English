class Form::WordCollection < Form::Base
  FORM_COUNT = 10 #ここで、作成したい登録フォームの数を指定
  attr_accessor :words 

  def initialize(attributes = {})
    super attributes
    self.words = FORM_COUNT.times.map { Word.new() } unless self.words.present?
  end

  def words_attributes=(attributes)
    self.words = attributes.map { |_, v| Word.new(v) }
  end

  def save_for(list_id)
    Word.transaction do
      self.words.map do |word|
        word.list_id = list_id
        word.save
      end
    end
      return true
    rescue => e
      return false
  end
end

