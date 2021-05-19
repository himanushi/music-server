module Word
  extend ActiveSupport::Concern

  module ClassMethods
    def ngram(n, text)
      results = []
      positions = []
      trim_text = text.gsub(/\s|\p{blank}/, "")

      0.upto(trim_text.length).map {|index| trim_text[index..index + n - 1] }.select {|txt| txt.length == n }
    end

    def ngram_attributes(n, text)
      id_name = self.table_name.gsub("_words", "_id")
      id = new[id_name]

      ngram(n, text).map.with_index do |chars, position|
        {
          id_name => id,
          text: chars,
          position: position
        }
      end
    end

    def bigram_attributes(text)
      ngram_attributes(2, text)
    end

    def search_ids(text)
      id_name = self.table_name.gsub("_words", "_id").to_sym
      n = 2
      chars = ngram(n, text)

      text_in = "'#{chars.join('\', \'')}'"
      text_like = "'%#{chars.join(',')}%'"

      results = ActiveRecord::Base.connection.select_all(<<-SQL)
        SELECT #{id_name} FROM
        (SELECT #{self.table_name}.* FROM #{self.table_name} WHERE #{self.table_name}.text IN (#{text_in})) t
        GROUP BY #{id_name}
        HAVING COUNT(*) > #{text.length - 2} AND GROUP_CONCAT(text ORDER BY position ASC SEPARATOR ',') LIKE #{text_like}
      SQL

      results.cast_values
    end
  end
end

# AppleMusicTrack.active.find_in_batches(batch_size: 500) {|ts| AppleMusicTrackWord.insert_all ts.map{|t|t.words_attributes}.flatten }
# SpotifyTrack.active.find_in_batches(batch_size: 500) {|ts| SpotifyTrackWord.insert_all ts.map{|t|t.words_attributes}.flatten }
