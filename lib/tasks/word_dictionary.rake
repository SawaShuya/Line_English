namespace :word_dictionary do
  desc "WordDictionary の初期値代入"
  require 'open-uri'
  require 'kconv'
  task :set_words => :environment do
    url = 'https://toraiz.jp/toeic/toeic-base/commonly-used-words'
    response_words = scrape(url)

    WordDictionary.transaction do
      response_words.map.each do |word|
        word = WordDictionary.new(word)
        word.save
      end
    end
      
    puts response_words 
  end

  def setup_doc(url)
    charset = 'utf-8'
    # html構造取得
    html = `curl -s #{url}`.toutf8
    doc = Nokogiri::HTML.parse(html, nil, charset)

    return doc
  end

  def scrape(url)
    # ページのNokogiri::HTML::Documentを取得。
    doc = setup_doc(url)

    words = doc.xpath("//div[@class='p-entry__body']/table/tbody/tr/td").map(&:text)

    response = exchange_hash(words)

    return response
  end

  def exchange_hash(array_words)
    table = []

    array_words.each_slice(2) do |english, japanese|
      hash = {
        english: english,
        japanese: japanese,
      }

      table << hash
    end
    return table
  end
end
