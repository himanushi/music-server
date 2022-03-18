# frozen_string_literal: true

class AppleMusicTrackWord < ::ActiveRecord::Base
  class << self
    def ngram(num, text)
      trim_text = text.gsub(/\s|\p{blank}/, '')

      0.upto(trim_text.length).map { |index| trim_text[index..index + num - 1] }
       .select { |txt| txt ? txt.length == num : false }
    end

    def ngram_attributes(id, num, text)
      ngram(num, text).map.with_index do |chars, position|
        {
          apple_music_track_id: id,
          text: chars,
          position: position
        }
      end
    end

    def bigram_attributes(id, text)
      ngram_attributes(id, 2, text)
    end

    def search_ids(text)
      select_col = 'apple_music_track_id'
      num = 2
      chars = ngram(num, text)

      text_in = ::ActiveRecord::Base.sanitize_sql_for_conditions([':chars', { chars: chars }])
      text_like = ::ActiveRecord::Base.sanitize_sql_like(chars.join(',').to_s)
      text_like = ::ActiveRecord::Base.sanitize_sql_for_conditions(['?', "%#{text_like}%"])

      results = ::ActiveRecord::Base.connection.select_all(<<-SQL)
        SELECT #{select_col} FROM
        (SELECT #{table_name}.* FROM #{table_name} WHERE #{table_name}.text IN (#{text_in})) t
        GROUP BY #{select_col}
        HAVING COUNT(*) > #{text.length - num} AND GROUP_CONCAT(text ORDER BY position ASC SEPARATOR ',') LIKE #{text_like}
      SQL

      results.cast_values
    end
  end
end
