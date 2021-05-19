class Word < ActiveRecord::Base
  belongs_to :searchable, polymorphic: true

  class << self
    def ngram(n, text)
      results = []
      positions = []
      trim_text = text.gsub(/\s|\p{blank}/, "")

      0.upto(trim_text.length).map {|index| trim_text[index..index + n - 1] }.select {|txt| txt.length == n }
    end

    def ngram_attributes(n, column_name, text)
      word = new
      ngram(n, text).map.with_index do |chars, position|
        {
          searchable_type: word.searchable_type,
          searchable_id: word.searchable_id,
          ngram: n,
          column_name: column_name,
          text: chars,
          position: position
        }
      end
    end

    def bigram_attributes(column_name, text)
      ngram_attributes(2, column_name, text)
    end

    def search_ids(searchable_type, column_name, text)
      n = 2
      chars = ngram(n, text)
      records = where(text: chars, searchable_type: searchable_type, column_name: column_name).order(:position)

      results = records.group_by(&:searchable_id).select do |key, values|

        ok = false

        values.each.with_index do |v, index|
          ok = chars[index % chars.length] == v.text
        end

        ok && (values.length / (text.length - 1)) > 0
      end

      results.keys.uniq
    end
  end
end
