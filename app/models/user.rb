class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[line]

  has_many :lists, dependent: :destroy
  has_many :questions, dependent: :destroy

  has_many :social_profiles, dependent: :destroy

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

  def list_index
    response = "〇登録リスト"
    lists.each do |list|
      response = response + "\n" + list.title
    end
    return response
  end

  def set_questions(list_id, limit, remember)
    self.result_message
    self.questions.destroy_all

    list = List.find(list_id)
    if remember
      words = list.words.where(is_remembered: false).sample(limit)
    else
      words = list.all.sample(limit)
    end

    words.each do |word|
      question = self.questions.new(word_id: word.id)
      question.answer = rand(1..4)
      question.save
    end
    
  end

  def result_message
    questions = self.questions.where(is_sent: true)
    if questions.present?
      @collect_count = 0
      response = "〇結果と解答！"

      questions.each do |question|
        if question.is_collected
          mark = "〇 "
          @collect_count += 1
        else
          mark = "× "
        end
        text = mark + question.english + " → " + question.japanese 
        response = response + "\n" + text
      end

      response = response + "\n" + @collect_count.to_s + " / " + questions.count.to_s + "正答！"
      if @collect_count == questions.count
        response = response + "\n全問正解だね！いい感じ"
      end

      return response
    end
  end

  def send_question
    question = self.questions.where(is_sent: false).first
    question_num = self.questions.where(is_sent: true).count + 1
    word_dictionaries = WordDictionary.all.sample(3)
    response = "No. " + question_num.to_s + "  " + question.word.english

    for i in 1..4 do
      j = 0
      if i == question.answer
        response = response + "\n" + i.to_s + ". " + question.word.japanese
      else
        response = response + "\n" + i.to_s + ". " + word_dictionaries[j]
        j += 1
      end
    end

    return response
  end
end
