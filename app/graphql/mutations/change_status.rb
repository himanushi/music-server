class Mutations::ChangeStatus < Mutations::BaseMutation
  description "ステータス変更。関連するアルバム, トラック, 各音楽サービスアルバム、各音楽サービストラックも同じステータスで更新される。"

  argument :artist_id, TTID, required: false, description: "変更したいアーティストID"
  argument :album_id, TTID, required: false, description: "変更したいアルバムID"
  argument :track_id, TTID, required: false, description: "変更したいトラックID"
  argument :status, StatusEnum, required: true, description: "変更したいステータス"

  field :model, ModelHasStatusUnion, null: true, description: "変更されたステータスを持ったモデル"
  field :error, String, null: true

  def mutate(artist_id: nil, album_id: nil, track_id: nil, status:)
    begin
      raise StandardError, "IDは一つだけ指定すること！" unless [artist_id, album_id, track_id].compact.size == 1

      klass, id =
        if artist_id.present?
          [Artist, artist_id]
        elsif album_id.present?
          [Album, album_id]
        elsif track_id.present?
          [Track, track_id]
        end

      model = klass.find(id)
      model.__send__(:"#{status}!")

      Rails.cache.clear
      {
        model: model,
        error: nil,
      }
    rescue => error
      {
        model: nil,
        error: error.message,
      }
    end
  end
end
