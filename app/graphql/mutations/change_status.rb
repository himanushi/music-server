class Mutations::ChangeStatus < Mutations::BaseMutation
  description "ステータス変更。関連するアルバム, トラック, 各音楽サービスアルバム、各音楽サービストラックも同じステータスで更新される。"

  argument :artist_id, TTID, required: false, description: "変更したいアーティストID"
  argument :album_id, TTID, required: false, description: "変更したいアルバムID"
  argument :track_id, TTID, required: false, description: "変更したいトラックID"
  argument :status, StatusEnum, required: true, description: "変更したいステータス"
  argument :only, Boolean, required: false, default_value: false, description: "true の場合は関連のステータスは変更しない。デフォルトは false。アーティスト限定"

  field :model, ModelHasStatusUnion, null: true, description: "変更されたステータスを持ったモデル"
  field :error, String, null: true

  def mutate(artist_id: nil, album_id: nil, track_id: nil, status:, only:)
    begin
      raise StandardError, "IDは一つだけ指定すること！" unless [artist_id, album_id, track_id].compact.size == 1

      klass, id =
        if artist_id.present?
          [::Artist, artist_id]
        elsif album_id.present?
          [::Album, album_id]
        elsif track_id.present?
          [::Track, track_id]
        end

      model = klass.find(id)

      if (klass == ::Artist) && ::Artist::FORCE_IGNORE_NAMES.include?(model.name)
        raise StandardError, "ヴァリアス・アーティストのステータス変更は絶対にしてはいけない！"
      end

      if only
        raise StandardError, "関連ステータスを変更しないで更新できるのはアーティストだけ。" unless Artist == klass
        model.update_column(:status, status)
      else
        model.__send__(:"#{status}!")
      end

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
