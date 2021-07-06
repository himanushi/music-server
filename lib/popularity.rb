class Popularity
  class << self
    def tally
      models = %w[artist album track playlist]
      magnification = 100

      ActiveRecord::Base.transaction do
        models.each do |model|
          ActiveRecord::Base.connection.execute(<<~SQL)
            UPDATE
            #{model.pluralize} t1,
            (
              SELECT it1.id, it1.pv + COALESCE(it2.popularity, 0) AS popularity
              FROM #{model.pluralize} it1 LEFT JOIN
              (
                SELECT f.favorable_id AS id, count(f.favorable_id) * #{magnification} AS popularity
                FROM favorites f LEFT JOIN #{model.pluralize} m ON m.id = f.favorable_id
                WHERE f.favorable_type = '#{model.camelcase}'
                GROUP BY f.favorable_id
              ) it2
              ON it1.id = it2.id
              WHERE it1.pv > 0 OR it2.popularity > 0
            ) t2
            SET
            t1.popularity = t1.pv + t2.popularity
            WHERE
            t1.id = t2.id
          SQL
        end
      end
    end
  end
end
